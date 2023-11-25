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
