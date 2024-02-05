## リデューサー

- `state`で記述されたロジックを一箇所にまとめるもの
- `state`の操作をしていたロジックを取り除き、ディスパッチと呼ばれる「なにをしたか」の情報を送るようにする

以下がディスパッチを送る例

```js
function handleDeleteTask(taskId) {
  dispatch(
    // アクションオブジェクト
    {
      type: 'deleted',
      id: taskId,
    }
  );
}
```

レデューサー関数は以下のようにする
同コンポーネント内に記述してもいいし、別ファイルに切り出してもよい

```js
function tasksReducer(tasks, action) {
  if (action.type === 'added') {
    return [
      ...tasks,
      {
        id: action.id,
        text: action.text,
        done: false,
      },
    ];
  } else if (action.type === 'changed') {
    return tasks.map((t) => {
      if (t.id === action.task.id) {
        return action.task;
      } else {
        return t;
      }
    });
  } else if (action.type === 'deleted') {
    return tasks.filter((t) => t.id !== action.id);
  } else {
    throw Error('Unknown action: ' + action.type);
  }
}
```

基本的にリデューサー関数はif/else文ではなく、`switch`文で書かれる(可読性の面から)

```js
function tasksReducer(tasks, action) {
  switch (action.type) {
    case 'added': {
      return [
        ...tasks,
        {
          id: action.id,
          text: action.text,
          done: false,
        },
      ];
    }
    case 'changed': {
      return tasks.map((t) => {
        if (t.id === action.task.id) {
          return action.task;
        } else {
          return t;
        }
      });
    }
    case 'deleted': {
      return tasks.filter((t) => t.id !== action.id);
    }
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}
```

`useState`と同様に`react`から`import`する必要がある

```js
import { useReducer } from 'react';
```

また以下のように`useReducer`フックは2つの引数を取る
- リデューサー関数
- 初期state

```js
const [tasks, dispatch] = useReducer(tasksReducer, initialTasks);
```
