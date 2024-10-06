## セキュリティ対策
## CSRF(クロスサイトリクエストフォージュリ)
第３者がUserを偽ってリクエストを飛ばし、レコードを削除したり更新したりすること。
Railsでこの対策として、session, authenticity_tokenを利用している。
リクエストにauthenticity_tokenを遅らせるようにして、sessionに埋め込まれたtokenと一致するかどうかを検証している。

何かしたら事情でこの検証を行いたくないときは,以下のようにdestroyアクションのみ検証を行わないようにする。
```rb
class BooksController < ApplicationController
  protect_from_forgery except: [ :destroy ]
  .
  .
```

