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

## ::について
以下のようにA::BとするとAの中に定義されているBクラスということを表現できる。

```rb
irb(main):001* class Out
irb(main):002*   class Inside
irb(main):003*     def greeting
irb(main):004*       puts 'Hello Iam inside'
irb(main):005*     end
irb(main):006*   end
irb(main):007> end
irb(main):009> inside_obj = Out::Inside.new
=> #<Out::Inside:0x0000000102567c70>
irb(main):010> inside_obj.greeting
Hello Iam inside
```
moduleでも同じように動く
```rb
irb(main):001* module Out
irb(main):002*   module Inside
irb(main):003*     def greeting
irb(main):004*       puts 'Hello Iam Inside'
irb(main):005*     end
irb(main):006*   end
irb(main):007> end
irb(main):011> include Out::Inside
irb(main):012> Out::Inside.greeting
Hello Iam Inside
```
