## コレクションレンダリング
コレクションをパーシャルに渡すことで、自動でそれぞれをレンダリングしてくれる
controller内で以下のように`@messages`という値を取得します。

```rb
  def show
    @messages = Message.all
  end
```

`@messages`にはこの時点では複数のMessageインスタンスが格納されています。
以下のようにその配列を全て表示する際に、view側でeachを使う方法もあります。

```rb
- @messages.each do |message|
  = render message
```

しかし、コレクションレンダリングを行うと以下のようにeachを書かずにかけます

```rb
# 省略しないケース
= render partial: 'message', collection: @messages
# 省略するケース
= render @messages
```
