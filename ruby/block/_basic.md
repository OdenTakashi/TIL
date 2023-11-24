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
## ブロックはクロージャー

クロージャーとは、定義時の変数などを保持している関数のこと。

```rb
irb(main):018:1* def my_method
irb(main):019:1*   x = 'Goodbye'
irb(main):020:1*   yield('cruel')
irb(main):021:0> end
=> :my_method

irb(main):022:0> x = 'Hello'
=> "Hello"
irb(main):023:0> my_method { |y| "#{x}, #{y} world"}
=> "Hello, cruel world"
```

このコードでブロック内で使われているローカル変数`x`は、メソッド内の`x`ではなく`x = 'Hello'`になる。
ブロックはローカル変数を包んで連れて行くという考え方。


