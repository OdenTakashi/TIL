## runner
以下のようにrunnerメソッドを使うことで、consoleを開かずにRubyのコードをRailsアプリのコンテキストで実行できる
```rb
❯ rails runner "p Blog.count"
1
```
