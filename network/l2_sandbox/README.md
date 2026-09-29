# L2 sandbox

Mac の中に Linux を 3 つ立てて、**IP / TCP を使わず Ethernet だけで**通信する実験場。

```text
host-a ---- スイッチ ---- スイッチ ---- host-c
:0a         (west)      (host-b)       :0c
```

host-b を普通のホストのままにすると、A→C は届かない。`make switch` で host-b を Linux ブリッジ（スイッチ）にすると、宛先 MAC が C のまま A→C が届く。

| ホスト  | セグメント | MAC                 |
| ------- | ---------- | ------------------- |
| host-a  | west       | `02:00:00:00:00:0a` |
| host-b  | west       | `02:00:00:00:00:0b` |
| host-b  | east       | `02:00:00:00:00:b1` |
| host-c  | east       | `02:00:00:00:00:0c` |

`02:` 始まりは「ローカル管理・ユニキャスト」の MAC。実機の NIC 製造番号ではない。host-b は NIC を 2 つ持つので MAC も 2 つある。

起動時に IPv4 / IPv6 アドレスを剥がす。残るのは MAC とリンクだけ。

## フレームの中身

自分で組み立てている Ethernet II フレーム（FCS はカーネル / NIC が付ける）。

```text
+------------------+------------------+------------+------------------+
| dst MAC (6)      | src MAC (6)      | type (2)   | payload          |
| 02:00:00:00:00:0b| 02:00:00:00:00:0a| 0x88B5     | hello + 0 padding|
+------------------+------------------+------------+------------------+
```

`0x88B5` は IEEE の実験用 EtherType。IPv4 (`0x0800`) や ARP (`0x0806`) ではないので、カーネルの IP スタックは中身を解釈しない。

## 必要環境

Linux の `AF_PACKET` が要るので、コンテナは Linux 側で動かす。Mac 本体では生 Ethernet を送れない。

- Docker（Docker Desktop か [Colima](https://github.com/abiosoft/colima)）
- `docker compose`

Colima の例:

```sh
brew install colima docker docker-compose
colima start
```

再起動後は `colima start` してからコンテナを上げる。止めたいときは `make down` のあと `colima stop`。

## 使い方

```sh
cd network/l2_sandbox
make test            # フレーム組み立てだけなら Linux 不要
make up
make ifinfo          # 3 台の MAC と、IP が無いことを確認
make demo            # ホストだと届かない → スイッチだと宛先 C のまま届く
```

`make demo` は同じフレーム（宛先 MAC = C）を 2 回送る。

1. host-b がホスト: 届かない
2. host-b がスイッチ: 届く。宛先 MAC は C のまま（B 向けに書き直さない）

手で動かすとき:

```sh
make switch          # host-b をスイッチにする
make host            # 普通のホストに戻す

# 端末 1
make recv HOST=host-c

# 端末 2
make send-c
```

## 観察

```sh
make dump
make dump HOST=host-c
# 別端末で
make send
```

Wireshark を使うなら、コンテナ内で pcap を書いて Mac 側で開く。

```sh
docker compose exec host-b tcpdump -i any -nn -c 4 -w /tmp/l2.pcap 'ether proto 0x88b5'
docker compose cp host-b:/tmp/l2.pcap /tmp/l2.pcap
```

## いま分かること

- 同じ L2 なら、宛先 MAC が分かっていれば IP は不要
- スイッチは自分宛として受け取らず、MAC 表を見て同じフレームを横に出す
- 普通のホストはそれをやらない。真ん中にいるだけではリレーしない
- ルータのバケツリレーは、このあと IP でやる（ホップごとに Ethernet を作り直す）

## このあと

コードはまだ Ethernet の送受信だけ。次は同じ sandbox の上に積む。

1. Broadcast (`ff:ff:ff:ff:ff:ff`)
2. ARP
3. IPv4
4. ICMP
5. 自作 ping
