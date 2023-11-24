# ブロック

ブロックは呼び出し可能オブジェクトの一つであり、ここには`Proc`や`lambda`などのオブジェクトが含まれる

## ブロックの基本

ブロックは{}またはdo..endで定義する。
1行のブロックには{}を使い、複数行の定義の場合はdo..endを使うという慣習がある。

ブロックを定義できるのは、メソッドを呼び出す時だけ。
ブロックはメソッドに渡され、メソッドは`yield`キーワードを使ってブロックをコールバックする。

```rb
irb(main):001:1* def a_method(a,b)
irb(main):002:1*   a + yield(a, b)
irb(main):003:0> end
=> :a_method

# ブロックをdo..endで定義する場合
irb(main):015:1* a_method(1,2) do |x,y|
irb(main):016:1*   (x + y) * 3
irb(main):017:0> end

# ブロックを{}で定義する場合
irb(main):004:0> a_method(1, 2) { | x, y| (x + y) * 3}
=> 10
```

メソッドの内部では`Kernel#block_given?`を使って、ブロックをの有無を確認できる。

```rb
irb(main):005:1* def a_method
irb(main):006:1*   return yield if block_given?
irb(main):007:1*   'ブロックがありません'
irb(main):008:0> end

irb(main):009:0> a_method
=> "ブロックがありません"

irb(main):011:0> a_method {'ブロックがあるよ'}
=> "ブロックがあるよ"
```
