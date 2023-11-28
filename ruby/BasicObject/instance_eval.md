# BasicObject#instance_evalメソッド

`instance_eval`に渡したメソッドは、レシーバーをselfにするため、privateメソッドやインスタンス変数にもアクセス可能。

```rb
irb(main):001:1* class MyClass
irb(main):002:2*   def initialize
irb(main):003:2*     @v = 1
irb(main):004:1*   end
irb(main):005:0> end
=> :initialize
irb(main):006:0> obj = MyClass.new
=> #<MyClass:0x000000010fbb4eb8 @v=1>
irb(main):007:1* obj.instance_eval do
irb(main):008:1*   p self
irb(main):009:1*   p @v
irb(main):010:0> end
#<MyClass:0x000000010fbb4eb8 @v=1>
1
```

また他のブロックと同じように、定義時のコンテキストも持っていくことが可能。

```rb
irb(main):014:0> v = 2
=> 2
irb(main):015:0> obj.instance_eval { @v = v }
=> 2
irb(main):016:0> obj.instance_eval { @v }
=> 2
```

## instance_execメソッド

`instance_eval`と似たメソッドとして、`instance_exec`メソッドが存在する。
`instance_exec`メソッドは`instance_eval`メソッドと違い、引数を受け取ることができる。

以下のように、D#twisted_methodにあるブロック内、インスタンンス変数`@x`, `@y`にアクセスできそうだが、<br>
`instance_eval`はselfをレシーバーにするため、Dのインスタンスの情報が抜け落ちてしまう。<br>
(`@y`をCのインスタンス変数だと解釈してしまうため)

```rb
irb(main):001:1* class C
irb(main):002:2*   def initialize
irb(main):003:2*     @x = 1
irb(main):004:1*   end
irb(main):005:0> end
=> :initialize
irb(main):006:1* class D
irb(main):007:2*   def twisted_method
irb(main):008:2*     @y = 2
irb(main):009:2*     C.new.instance_eval { "@x: #{@x}, @y: #{@y}" }
irb(main):010:1*   end
irb(main):011:0> end
=> :twisted_method
irb(main):012:0> D.new.twisted_method
=> "@x: 1, @y: "
```

この際に、`instance_exec`を使って引数として、@yを渡してあげることで、二つのインスタンス変数を同じスコープに入れることができる。

```rb
irb(main):027:1* class D
irb(main):028:2*   def twisted_method
irb(main):029:2*     @y = 2
irb(main):030:2*     C.new.instance_exec(@y) { |y| "@x: #{@x}, @y: #{y}" }
irb(main):031:1*   end
irb(main):032:0> end
=> :twisted_method

irb(main):033:0> D.new.twisted_method
=> "@x: 1, @y: 2"
```
