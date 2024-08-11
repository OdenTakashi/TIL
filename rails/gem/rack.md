## Rack
HTTP RequestやResponeseをラップしてくれている
RubyのWebアプリケーションとWebサーバーの間のインターフェースを標準化するためのミドルウェアライブラリ

https://github.com/rack/rack

### refererメソッド
HTTPのheaderから前回アクセスしたURLを取得してくれている
```rb
def referer
  get_header('HTTP_REFERER')
end
```
https://github.com/rack/rack/blob/main/lib/rack/request.rb#L100

