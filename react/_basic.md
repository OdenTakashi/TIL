# React
- ユーザーインタフェースをコンポーネントに分けて構築
  - コンポーネントはJSの関数

## JSX要素
```js
export default function Square() {
  return　<button className="square">X</button>
}
```

```js
<button className="square">X</button>
```

この部分はJSX要素と呼ばれ、HTMLタグとJSのコードの組み合わせ

```js
export default function Square() {
  return <button className="square">X</button><button className="square">X</button>;
}
```

ボタンを複数用意したい場合は、こう書いてしまうと

> /src/App.js: Adjacent JSX elements must be wrapped in an enclosing tag. Did you want a JSX Fragment <>...</>?

というエラーが出てしまう。

```js
export default function Square() {
  return (
    <>
      <button className="square">X</button>
      <button className="square">X</button>
    </>
  );
}
```

このように、一つのJSX要素として返す必要がある

## propsの渡し方

```js
function Square({ value }) {
  return <button className="square">{value}</button>;
}

export default function Board() {
  return (
    <div className="board-row">
      <Square value="1" />
    </div>
  );
}
```

波括弧で変数を囲い、Squareコンポーネントにprops指定

### アロー関数

```js
<Square value={squares[0]} onSquareClick={() => handleClick(0)} />
```

関数を短く定義する方法

### スプレッド構文
```js
setHistory([...history, nextSquares])
```

`histroy`の末尾に`nextSquares`を追加する

```js
function Profile({ person, size, isSepia, thickBorder }) {
  return (
    <div className="card">
      <Avatar
        person={person}
        size={size}
        isSepia={isSepia}
        thickBorder={thickBorder}
      />
    </div>
  );
}
```

このようなコードはスプレッド構文を使って以下のように書ける

```js
function Profile(props) {
  return (
    <div className="card">
      <Avatar {...props} />
    </div>
  );
}
```

## 変数展開

```js
const baseUrl = 'https://i.imgur.com/';
const person = {
  name: 'Gregorio Y. Zara',
  imageId: '7vQD0fP',
  imageSize: 's',
  theme: {
    backgroundColor: 'black',
    color: 'pink'
  }
};

export default function TodoList() {
  return (
    <div style={person.theme}>
      <h1>{person.name}'s Todos</h1>
      <img
        className="avatar"
        src="{baseUrl}{person.imageId}{person.imageSize}.jpg"
        alt={person.name}
      />
      <ul>
        <li>Improve the videophone</li>
        <li>Prepare aeronautics lectures</li>
        <li>Work on the alcohol-fuelled engine</li>
      </ul>
    </div>
  );
}
```

```js
src="{baseUrl}{person.imageId}{person.imageSize}.jpg"
```

このままでは展開されない

```js
src={baseUrl + person.imageId + person.imageSize + '.jpg'}
```

このように{}内で展開する

## children

JSXタグ内でコンテンツをネストした場合、親側のコンポーネントではそのコンテンツを`children`というpropsとして受け取る

```js
function Card({children}) {
  return(
      <div className="card">
        <div className="card-content">
          {children}
        </div>
      </div>
  )
}

export default function Profile() {
  return (
    <div>
      <Card>
        <h1>Photo</h1>
        <img
          className="avatar"
          src="https://i.imgur.com/OKS67lhm.jpg"
          alt="Aklilu Lemma"
          width={70}
          height={70}
        />
      </Card>
      <Card>
        <h1>About</h1>
        <p>Aklilu Lemma was a distinguished Ethiopian scientist who discovered a natural treatment to schistosomiasis.</p>
      </Card>
    </div>
  );
}
```
