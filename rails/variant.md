## variant
テンプレート切り替え機能。
以下のように`iPhone`からのアクセスの場合、variantに`mobile`を代入すると
```rb
    def detect_mobile_variant
      request.variant = :mobile if request.user_agent =~ /iPhone/
    end
```
`index.html+mobile.erb`のテンプレートに切り替わる。
なので切り替え先テンプレートの切り替えは`~html`+`+{variant}.erb`とする。　
