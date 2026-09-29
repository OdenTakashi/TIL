#!/bin/sh
set -eu

cd "$(dirname "$0")/.."

listen() {
  host=$1
  log=$2
  rm -f "$log"
  docker compose exec -T "$host" sh -c 'timeout 6 ruby recv.rb' > "$log" 2>&1 &
  recv_pid=$!
}

finish_recv() {
  sleep "$1"
  kill "$recv_pid" 2>/dev/null || true
  wait "$recv_pid" 2>/dev/null || true
}

show_recv() {
  title=$1
  log=$2
  echo "=== $title ==="
  if grep -q "received" "$log"; then
    cat "$log"
  else
    echo "届かなかった"
    cat "$log"
  fi
  echo
}

echo "=== topology ==="
echo
echo "  host-a ---- スイッチ ---- スイッチ ---- host-c"
echo "  :0a        (west)      (host-b)      :0c"
echo
echo "宛先 MAC はずっと C。スイッチは自分宛として受け取らず、横に出す。"
echo

echo "=== いったん host-b を普通のホストに戻す ==="
docker compose exec -T host-b sh /app/scripts/as-host.sh
echo

echo "=== 1. スイッチではない: host-a -> host-c (:0c) ==="
listen host-c /tmp/l2-c-as-host.log
sleep 1
docker compose exec -T host-a ruby send.rb hello 02:00:00:00:00:0c
finish_recv 2
echo
show_recv "host-c" /tmp/l2-c-as-host.log

echo "=== host-b をスイッチにする ==="
docker compose exec -T host-b sh /app/scripts/as-switch.sh
echo
docker compose exec -T host-b ruby ifinfo.rb
echo

echo "=== 2. スイッチ経由: host-a -> host-c (:0c) ==="
echo "送るフレームの宛先 MAC は C のまま。B 向けに書き直さない。"
listen host-c /tmp/l2-c-as-switch.log
sleep 1
docker compose exec -T host-a ruby send.rb hello 02:00:00:00:00:0c
finish_recv 2
echo
show_recv "host-c" /tmp/l2-c-as-switch.log
