## 単一参照テーブル
同一のテーブル構造を持ったテーブル同士をひとまとめにして作成するテーブル。<br>

### メリット
- テーブル数を減らすことができ、ER図やスキーマがシンプルになる
- コード検索のSQLを共通化でき、保守運用が容易になる

### デメリット
- 不確かなカラムに対して、最適な型を宣言しずらい
- 誤ったコードタイプを指定しても、エラーになることがないため、バグに気づきにくい
- 列の型と実際のデータ型が異なるため、FKを付与しづらい
