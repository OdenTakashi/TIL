## helperメソッド
view template内で利用できるメソッド。

### url_for
アプリ内のパスを構築できるメソッド。

名前付きパスを引数で渡して、パスを生成できる
```rb
irb(#<#<Class:0x000000012a6f2d10>...):004> url_for(edit_profile_path)
=> "/profile/edit"
```

controller名とaction名を渡して、パスを生成できる
```rb
irb(#<#<Class:0x000000012a6f2d10>...):013> url_for(controller: :publishers, action: :show, id: 1)
=> "/publishers/1"
```

他にもパラメーター追加でクエリパラメーターを追加することができる
```rb
irb(#<#<Class:0x000000012a6f2d10>...):014> url_for(controller: :publishers, action: :show, id: 1, detailed: 'true')
=> "/publishers/1?detailed=true"
```

### link_to
名前付きパスだけでなく、controller, action名, パラメーター追加もできる
```rb
irb(#<#<Class:0x000000012a6f2d10>...):015> link_to('publisher link', controller: :publishers, action: :show, id: 1, detailed: 'true')
=> "<a href=\"/publishers/1?detailed=true\">publisher link</a>"
```

### time_ago_in_words
引数で渡した時刻と現在時刻のあいだにどれだけ開きがあるかを表示する。
```rb
book-admin(dev)> helper.time_ago_in_words(Time.current)
=> "less than a minute"
book-admin(dev)> helper.time_ago_in_words(Time.current + 3.days)
=> "3 days"
```

### number_with_delimiter
長い数字に対して、区切り文字を入れてくれる
```rb
book-admin(dev)> helper.number_with_delimiter(1234567890)
=> "1,234,567,890"
book-admin(dev)> helper.number_with_delimiter(1234567890, delimiter: '@')
=> "1@234@567@890"
```
