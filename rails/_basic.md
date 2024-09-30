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
