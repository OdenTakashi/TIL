## テーブルの構成要素
- 行(レコード)
- 列(カラム)
- キー
  - 主キー
    - 一位に識別する値
    - 重複したデータを持たせてはいけない
  - 外部キー
    - 参照整合性制約をもたらす
    - 
  - 複合キー
    - 複数キーを組み合わせることで主キーを作り出せない場合
  - 候補キー
    - スーパーキーとも呼ばれる
    - 主キーとなる候補

キーとなる列には可長編文字列ではなく、固定長文字列を利用する。
同じレコードを指してるはずが、少しの差で別レコードとなってしまうため。

### 制約
- NOT NULL制約
  - NULLを禁止する
- 一意制約
  - 一意性を求める制約
- CHECK制約
  - 列のとりうる値の範囲を制限する制約

### テーブルと列の名前
以下の文字が利用可能
- 半角アルファベット
- 半角数字
- アンダーバー

最初はアルファベット
- 2009_uriageなど、先頭にアルファベットは禁止
名前は重複してはいけない
- 同じ名前、列は村座してはいけない
