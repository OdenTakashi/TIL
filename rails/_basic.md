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


