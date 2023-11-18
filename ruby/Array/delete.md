# deleteメソッド
Array#deleteは指定した値を配列から全て取り除きます。
返り値は削除した要素。
破滅的に変更します。

```rb
irb(main):001:0> ary = [1,2,3]
=> [1, 2, 3]
irb(main):002:0> ary.delete(2)
=> 2
irb(main):003:0> ary
=> [1, 3]
```
