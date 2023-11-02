# to_i
## 引数がない場合

レシーバーを10進数で表現された整数として解釈し、整数に変換します。

```rb
irb(main):001:0> str = '100'
=> "100"
irb(main):002:0> str.class
=> String
irb(main):003:0> str.to_i
=> 100
irb(main):004:0> str.class
=> String
```

## 引数が0の場合

レシーバーの接頭辞から、n進数なのかを判断し、10進数へと変換します。
判断できる接頭辞は以下の通りです。

### 2進数
- 0b

### 8進数
- 0
- 0o

### 10進数
- 0d

### 16進数
- 0x

```rb
irb(main):001:0> '0b10'.to_i(0)
=> 2
irb(main):002:0> '070'.to_i(0)
=> 56
irb(main):003:0> '0o70'.to_i(0)
=> 56
irb(main):004:0> '0d15'.to_i(0)
=> 15
irb(main):005:0> '0x10'.to_i(0)
=> 16
```

## 引数が0,2 ~ 36の場合

引数で指定した新数へと変換。

```rb
irb(main):006:0> "0b0001".to_i(2)
=> 1
```

## 引数が0,2 ~ 36の場合

`ArgumentError`が発生します。

```rb
irb(main):007:0> "0b0001".to_i(55)
(irb):7:in `to_i': invalid radix 55 (ArgumentError)
```
