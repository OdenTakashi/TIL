# Enumerable
Array, Hash, Range, Enumeratorクラスでincludeされているモジュール。
全てのメソッド内でeachが使われている。

```rb
irb(main):001:0> Array.ancestors
=> [Array, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
irb(main):002:0> Hash.ancestors
=> [Hash, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
irb(main):003:0> Range.ancestors
=> [Range, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
irb(main):004:0> Enumerator.ancestors
=> [Enumerator, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
```
