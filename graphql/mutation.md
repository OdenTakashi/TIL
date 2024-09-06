## mutation
 'POST'、 'PUT' 、 'PATCH' 、 'DELETE'のようにバックエンドでの「ミューテーション」を引き起こすGraphQLクエリの一種。

以下は作成したtodoの要素を返すmutation

```js
mutation {
  insert_todos(objects: [{title: "new todo"}]) {
    returning {
      id
      title
      is_completed
      is_public
      created_at
    }
  }
}
```

一般的には引数はparameterとして渡す

```js
# mutationにparameterを渡す
mutation($todo: todos_insert_input!){
  insert_todos(objects: [$todo]) {
    returning {
      id
    }
  }
}

# 変数定義
{
  "todo": {
    "title": "A new dynamic todo"
  }
}
```

