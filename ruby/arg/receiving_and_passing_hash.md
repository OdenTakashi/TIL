## Hash受け取りと受け渡し
以下のようにメソッドに`hash`を受け渡す際に、そのまま`hash`を引数で渡すと`hash`がそのまま出力される

```rb
irb(main):009:1* def test2(a)
irb(main):010:1*   puts a
irb(main):011:0> end

irb(main):012:0> test2(hash)
{:a=>"1", :b=>"2"}
```

しかし、渡す際に`**hash`のように渡すと展開された`hash`が引数にわたるため、受け取り側でキー指定をするとkey, valueで受け取ることができる。
以下の`**b`のように受け取ると指定されなかった`hash`の差分を受け取ることができる。

```rb
irb(main):003:0> hash
=> {:a=>"1", :b=>"2"}

irb(main):004:1* def test(a: , **b)
irb(main):005:1*   puts a
irb(main):006:1*   puts b
irb(main):007:0> end

irb(main):008:0> test(**hash)
1
{:b=>"2"}

```
