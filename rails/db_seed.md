## rails db:seed:replant
既存のレコード削除を行う、再度seed実行
```rb
❯ rails db:seed
❯ rails runner "p Blog.count"
2
❯ rails db:seed:replant
❯ rails runner "p Blog.count"
1
```
