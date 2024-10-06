## ActiveRecord::Enum
列挙型、enum型と呼ばれる。
DB上では数値として扱われるものに、アプリ上で別名を与える。

以下のようなschemaとモデルがあった場合、
```rb
# schema

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.date "published_on"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publisher_id", null: false
    t.integer "sales_status"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

# Bookモデル

class Book < ApplicationRecord
.
.
  enum sales_status: {
    reservation: 0,
    now_on_sale: 1,
    end_of_print: 2
  }
  .
  .
end

# console
book-admin(dev)* Book.create(
book-admin(dev)*   name: 'enum book 1',
book-admin(dev)*   sales_status: :now_on_sale,
book-admin(dev)*   publisher:  Publisher.find(1),
book-admin(dev)*   price: 1000
book-admin(dev)> )
=>
#<Book:0x000000012485ea10
 id: 15,
 name: "enum book 1",
 published_on: nil,
 price: 1000,
 created_at: "2024-10-06 02:20:37.704092000 +0000",
 updated_at: "2024-10-06 02:20:37.704092000 +0000",
 publisher_id: 1,
 sales_status: "now_on_sale">
```

### 参照の際の戻り値
文字列の値を参照する

```rb
book-admin(dev)> Book.last.sales_status
  Book Load (0.2ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> "now_on_sale"
```

### 状態の確認
Enumで定義された状態を確認する場合は,ステータスごとに状態を問い合わせることができる。

```rb
book-admin(dev)> Book.last.now_on_sale?
  Book Load (0.2ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> true
book-admin(dev)> Book.last.end_of_print?
  Book Load (0.3ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> false
```

### 状態の更新
ステータス!で除隊を更新することができる。

```rb
book-admin(dev)> Book.last.end_of_print!
  Book Load (0.2ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ?  [["LIMIT", 1]]
  TRANSACTION (0.0ms)  begin transaction
  Book Update (0.2ms)  UPDATE "books" SET "updated_at" = ?, "sales_status" = ? WHERE "books"."id" = ?  [["updated_at", "2024-10-06 02:23:01.011051"], ["sales_status", 2], ["id", 15]]
  TRANSACTION (0.3ms)  commit transaction
=> true
```

### scope
Enumで定義したカラムに対して、該当するレコードを引っ張ってくるscope, 該当しないレコードを引っ張ってくるscopeが追加される

```rb
book-admin(dev)> Book.now_on_sale
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."sales_status" = ? /* loading for pp */ LIMIT ?  [["sales_status", 1], ["LIMIT", 11]]
=> []
book-admin(dev)> Book.not_now_on_sale
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE "books"."sales_status" != ? /* loading for pp */ LIMIT ?  [["sales_status", 1], ["LIMIT", 11]]
=>
[#<Book:0x000000010515c6c8
  id: 15,
  name: "enum book 1",
  published_on: nil,
  price: 1000,
  created_at: "2024-10-06 02:20:37.704092000 +0000",
  updated_at: "2024-10-06 02:23:01.011051000 +0000",
  publisher_id: 1,
  sales_status: "end_of_print">]
```
