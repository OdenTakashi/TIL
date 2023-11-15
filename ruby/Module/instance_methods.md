# instance_methods

レシーバーのクラス、モジュールで定義されている、public, protectedメソッドの一覧を表示します。
引数でfalseを指定した場合、そのモジュールで定義されているメソッドのみを表示します。

```rb
irb(main):001:1* class Greeting
irb(main):002:2*   def initialize(message)
irb(main):003:2*     @message = message
irb(main):004:1*   end
irb(main):005:2*   def greeting
irb(main):006:2*     puts 'Hello'
irb(main):007:1*   end
irb(main):008:0> end
=> :greeting
irb(main):009:0> my_object = Greeting.new('Hi')
=> #<Greeting:0x00007fedd727b858 @message="Hi">
irb(main):010:0> my_object.class.instance_methods(false)
=> [:greeting]
```
