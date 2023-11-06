## 破滅的変更
破滅的メソッドはオブジェクトの値そのもをの変更します。

以下のようにaとbは同じオブジェクトIDを見ているとします。

```rb
irb(main):001:0> a = 'hoge'
=> "hoge"
irb(main):002:0> b = a
=> "hoge"
irb(main):003:0> a.object_id
=> 30680
irb(main):004:0> b.object_id
=> 30680
```

この状態で破滅的変更を行うと、aとbという変数が見えていた、オブジェクトIDの値自体が変更されるため
a,bともに変更されます。

```rb
irb(main):005:0> a.gsub!('hoge', 'piyo')
=> "piyo"
irb(main):006:0> a
=> "piyo"
irb(main):007:0> b
=> "piyo"
irb(main):008:0> a.object_id
=> 30680
irb(main):010:0> b.object_id
=> 30680
```


今度は破滅的変更ではない場合、オブジェクトその物の値を変更せず、新しいオブジェクトを生成するため、
a,bでは異なる結果になります。

```rb
irb(main):013:0> a = a.gsub('piyo', 'fuga')
=> "fuga"
irb(main):014:0> a
=> "fuga"
irb(main):015:0> b
=> "piyo"
irb(main):016:0> a.object_id
=> 165400
irb(main):017:0> b.object_id
=> 30680
```
