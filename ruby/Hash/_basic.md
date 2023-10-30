# Hash

## 空のHashオブジェクト生成

### Hash[]

```rb
irb(main):001:0> hash = Hash[]
=> {}
irb(main):002:0> hash.class
=> Hash

irb(main):003:0> Hash[:key, 'value']
=> {:key=>"value"}
```

### Hash({})

```rb
irb(main):004:0> hash = Hash({})
=> {}
irb(main):005:0> hash.class
=> Hash

irb(main):009:0> Hash({key: 'value'})
=> {:key=>"value"}
```

### {}

```rb
irb(main):001:0> hash = {}
=> {}
irb(main):002:0> hash.class
=> Hash

irb(main):003:0> hash = {key: 'value'}
=> {:key=>"value"}
```

### Hash.new

```rb
irb(main):004:0> hash = Hash.new
=> {}
irb(main):005:0> hash.class
=> Hash

# Hash.new('default')
# => デフォルト値を設定。
# => valueを指定していない時に挿入される
# => p, putsなどで参照する際は無視される

irb(main):001:0> hash = Hash.new('default')
=> {}
irb(main):002:0> hash[:key]
=> "default"
irb(main):003:0> p hash
{}
```
