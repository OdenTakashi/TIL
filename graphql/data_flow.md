## 基本的なデータフロー
1. HTTP RequestのJSONオブジェクトのBodyのqueryキーにStringとしてGraphQLクエリを格納してサーバーに送信する。
   - ここでGraphQL queryはJSONではない。
```
Body:
  {
    "query": "query {user (id: 1) {id name}}"
  }
```
2. サーバーはJSONオブジェクトを取得して、クエリ文字列を抽出。GraphQLの構文とgraphデータのモデル（GraphQLスキーマ）に従って、サーバーはGraphQL クエリの処理と検証を実施。
3. GraphQL APIサーバーはデータベースや他のサービスを呼び出して、クライアントが要求したデータを取得。
4. サーバーはデータを取得し、JSONオブジェクトにしてからクライアントに返却。
