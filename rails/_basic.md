## Railsの思想
Railsは4つの思想を打ち出している
- Coc(Convention over Configuration)
- DRY(Don't Repeat Yourself)
- REST(Representational State Transfer)
- 自動テスト

### CoC
設定より規約を意識することで、本来感心すべきビジネスロジックに集中することができる。
本質的なビジネスロジックより手前にある、ディレクトリ構造であったり、DBの命名規則などなどはあらかじめ規約として決まっているのでそこからの差異があれば書いていきましょうという考え方。
これにより、開発者同士で不要なコミュニケーションを減らし、関心を集中させることができる。

### DRY
同じことは繰り返さない、情報の重複をなくし、1つのことは1つの場所に記述する。

### REST
全てのリソースには一意となる識別子がある -> URI
そのURIに対して操作を行うといった考え方。

### 自動テスト
Ruby, RORでは自動テストを行う文化を重要視している。

## ネストしたmodelを利用する際の注意点
### controller
parentモデルとchildモデルがあり、Parent::Childとなっている場合
view側でupdateアクションにリクエストが飛んできた際に以下のようにcontrollerで処理をしてしまうと
セキュリテイに良くない。
-> parameterに別のidを仕込まれてしまった場合に対処できないため

```rb
Class Parent::Child < ActiveModel
  before_action :set_child, only: :update

  def update(update_params)
    # updateの処理
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end
end
```

この実装方法ではParent1に紐づくChildのみを扱いたいが、Parent2に紐づくChild2も取得できてしまう
なので、実際に紐づいているParentから取得すると堅牢になる

```rb
Class Parent::Child < ActiveModel
  before_action :set_child, only: :update
  before_action :set_parent, only: :update

  def update(update_params)
    # updateの処理
  end

  private
  def set_parent
    @parent = Parent.findy(params[:id])
  end

  def set_child
    @child = parent.child.find(params[:id])
  end
end
```

## Rails
### 関連付け
```rb
# models/piyo.rb

has_xxx: hoge_fuga
#実際に見て欲しいのはOden/hoge_fuga.rbだとする
#->HogeFuga or Piyo::HogeFugaとしか解釈されない
```
なのでOden/hoge_fuga.rbを見て欲しいならば
```rb
# models/piyo.rb

has_xxx: hoge_fuga, class_name: Oden::HogeFuga
```
とする。

またmodels/piyo.rb直下のmodelならば以下のようにかける
```rb
# models/piyo.rb
# 見にいきたいのはmodels/piyo/takashi.rb

has_xxx: takashi
```

## belongs_toで追加されるメソッド
belongs_toで関連付けを貼ると以下のメソッドが追加される

```rb
association
association=(associate)
build_association(attributes = {})
create_association(attributes = {})
create_association!(attributes = {})
reload_association
reset_association
association_changed?
association_previously_changed?
```

## コールバック
- コールバック処理内で, update, saveのようなオブジェクトに副作用を与えるメソッドは使わないほうがいい
-> commitのタイミングで不具合が起きる可能性がある
考えられる危険性
- 無限ループのリスク
->update,saveを呼ぶことで再度コールバックが呼ばれる可能性がある
- 予期せぬ副作用の発生
- トランザクションの問題
->トランザクション内でデータの状態が変わるため、不整合が起きる可能性がある

### 対処法
データベースのアクセスを避けるために、属性に直接代入などをする
```rb
無限ループのリスク
予期せぬ副作用の発生
トランザクションの問題
```

## create!にブロックを渡した時の注意点
```rb
# parentとchildが1対多の関係の場合

parent.create! do |parent|
  parent.create_child!(args)
end

# -> これは以下のエラーで落ちます
# ActiveRecord::RecordNotSaved:
# You cannot call create unless the parent is saved

# 理由として、Rails側がcreate!の処理よりも前にブロックを評価してしまうためです。
# なので以下のようにすれば、newで止めてくれるためエラー落ちせずに実行されます

parent.create! do |parent|
  parent.build_child(args)
end

## find, find_by
findはPKとしてIDを指定する。
戻り値はレコードがある場合はクラスのインスタンス、ない場合はActiveRecord::RecordNotFoundを返す

find_byはID以外のカラムで検索。
戻り値はクラスのインスタンス、ない場合はnilを返す

## where
複数件レコードを検索する。
戻り値はActiveRecord::Relationクラスのインスタンス

### ActiveRecord::Relation
SQLを書くようにrubyのメソッドでクエリ構築を行える。
検索メソッドを呼ぶだけではSQLは発行されない。
Enumerableメソッドや出力メソッドを利用した際に発行される。

## LIKE句
あいまい検索をする際に利用する。
以下のように記述するとBookから始まるnameを持つBookレコードを検索してくれる。

```rb
Book.where("name like ?", "Book%")
```
この際に気をつけるのが引数を取る際には、ワイルドカードがエスケープされないという点
このように引数にワイルドカードが入っていた場合は`%ok%`として認識されてしまう。

```rb
book-admin(dev)> str_including_wild_card = "%ok"
=> "%ok"
book-admin(dev)> Book.where("name like ?", "#{str_including_wild_card}%")
```

その際は引数ないのワイルドカードをエスケープする必要がある。

```rb
book-admin(dev)> Book.where("name like ?", Book.sanitize_sql_like(str_including_wild_card) + "%")
```

## scope
利用頻度の高い検索条件を定義して再利用可能にする
scope内でfind_byを利用する際の注意点

以下のように実行するとscopeがnilを返す場合は、デフォルトスコープ(ここではBook.all)が実行され、ActiveRecord::Relationが返却される
```rb
class Book < ApplicationRecord
  scope :find_price, ->(price) { where(find_by(price:)) }
end


book-admin(dev)> Book.find_price(10000)
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE "books"."price" = ? LIMIT ?  [["price", 10000], ["LIMIT", 1]]
  Book Load (0.1ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT ?  [["LIMIT", 11]]
=>
[#<Book:0x00000001206aca90
  id: 1,
  name: "Book 1",
  published_on: "2019-11-24",
  price: 1000,
  created_at: "2024-09-30 13:03:44.846541000 +0000",
  updated_at: "2024-09-30 13:03:44.846541000 +0000">,
 #<Book:0x000000011f39e9d0
  id: 2,
  name: "Book 2",
  published_on: "2019-10-24",
  price: 2000,
  created_at: "2024-09-30 13:03:44.850462000 +0000",
  updated_at: "2024-09-30 13:03:44.850462000 +0000">,
 #<Book:0x000000011f39e890
  id: 3,
  name: "Book 3",
  published_on: "2019-09-24",
  price: 3000,
  created_at: "2024-09-30 13:03:44.851958000 +0000",
  updated_at: "2024-09-30 13:03:44.851958000 +0000">,
 #<Book:0x000000011f39e610
  id: 4,
  name: "Book 4",
  published_on: "2019-08-24",
  price: 4000,
  created_at: "2024-09-30 13:03:44.853341000 +0000",
  updated_at: "2024-09-30 13:03:44.853341000 +0000">,
 #<Book:0x000000011f39e4d0
  id: 5,
  name: "Book 5",
  published_on: "2019-07-24",
  price: 5000,
  created_at: "2024-09-30 13:03:44.854401000 +0000",
  updated_at: "2024-09-30 13:03:44.854401000 +0000">]
```

## validates :hogehoge, numeriality: ~~~
属性の数値のみが使われていることをバリデーションする。
### option

#### only_integer
`validates :price, numericality: { only_integer: true }`
`/\A[+-]?\d+\z/`の正規表現を利用してマッチングが行われる
デフォルトのエラーメッセージは「must be an integer」

#### greater_than
指定の値よりも大き苦なければいけないことを表現
デフォルトのエラーメッセージは、「must be greater than %{count}」

#### greater_than_or_equal_to
指定の値以上でないければいけないことを表現
デフォルトのエラーメッセージは「must be greater than or equal to %{count}」

#### equal_to
指定した値と一致している必要があることを表現
デフォルトのエラーメッセージは「must be greater than or equal to %{count}」

#### less_than
指定した値よりも小さくなければいけないことを表現
デフォルトのエラーメッセージは「must be less than %{count}」

#### less_than_or_equal_to
指定の値以下でなければいけないことを表現
デフォルトのエラーメッセージは「must be less than or equal to %{count}」

#### other_than
指定した値以外でなければいけないことを表現
デフォルトのエラーメッセージは「must be other than %{count}」

#### in
指定した範囲に値が含まれていることを表現
デフォルトのエラーメッセージは「must be in %{count}」

#### odd: true
奇数でなければいけないことを表現
デフォルトのエラーメッセージは「must be odd」

#### even: true
偶数でなければいけないことを表現
デフォルトのエラーメッセージは「must be even」
