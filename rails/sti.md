## STI( Single Table Inheritance )
親モデルと子モデルが同じテーブルに保存されるRailsではデフォルトの動作
親モデルと子モデルが別テーブルを持っていても、子モデルが親モデルを継承していれば親テーブルに保存される
```rb
sti-sample(dev)> Child.create(name: :john)
  TRANSACTION (0.1ms)  begin transaction
  Child Create (1.7ms)  INSERT INTO "parents" ("name", "created_at", "updated_at") VALUES (?, ?, ?) RETURNING "id"  [["name", "john"], ["created_at", "2024-10-15 12:58:54.923403"], ["updated_at", "2024-10-15 12:58:54.923403"]]
  TRANSACTION (0.2ms)  commit transaction
=> #<Child:0x00000001077ec810 id: 3, name: "john", created_at: "2024-10-15 12:58:54.923403000 +0000", updated_at: "2024-10-15 12:58:54.923403000 +0000">
```

### 親モデルが抽象クラスの場合
親モデルが抽象クラスでテーブルを持たない場合( ApplicationRecordのように )はクラスないに以下を記述

```rb
class Parent < ApplicationRecord
  self.abstract_class = true
end
```
