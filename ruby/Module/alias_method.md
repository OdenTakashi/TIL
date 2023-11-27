# Module#alias_methodメソッド
`Module#alias_method`メソッドはRubyのメソッドに別名をつけることができる
`alias_method 新しい名前, 元の名前`(メソッド名はシンボルもしくは文字列)

```rb
irb(main):018:1* class MyClass
irb(main):019:2*   def my_method
irb(main):020:2*     'my_method'
irb(main):021:1*   end
irb(main):022:1*   alias_method :m, :my_method
irb(main):023:0> end
=> :m

irb(main):024:0> obj = MyClass.new
=> #<MyClass:0x000000010eb64bd0>
irb(main):025:0> obj.my_method
=> "my_method"
irb(main):026:0> obj.m
=> "my_method"
```
