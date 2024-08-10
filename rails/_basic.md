
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


