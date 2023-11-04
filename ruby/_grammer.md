# 変数の初期化

以下の場合、変数xを初期化していないため、代入できない。

```rb
irb(main):001:1* def hoge
irb(main):002:2*   (1..3).each do |i|
irb(main):003:2*     x += 1
irb(main):004:1*   end
irb(main):005:1*   puts x
irb(main):006:0> end
=> :hoge
irb(main):007:0> hoge
(irb):3:in `block in hoge': undefined method `+' for nil:NilClass (NoMethodError)
```

