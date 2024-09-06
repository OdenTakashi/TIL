## subscription
サーバーがプッシュしたデータを取得できる。
アプリからのイベントの形を管理できる。
ウェブソケットのエンドポイントに送信されるサブスクリプションクエリ文字列

ex.) subscriptionにuserを登録しておけば、userが変更されるたびに検知が可能
```js
subscription {
  online_users {
    id
    last_seen
    user {
      name
    }
  }
}
```
