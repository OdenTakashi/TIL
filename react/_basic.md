# React
- 時間の経過とともに変わっていくものを`state`と呼ぶ
- ユーザーインタフェースをコンポーネントに分けて構築
  - コンポーネントはJSの関数
- コンポーネントは準関数であると仮定している

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

## CSS指定
`style`に渡す値はJSオブジェクトとしてキャメルケースを渡す。

```js
function Item({ name, importance }) {
  return (
    <li style={{fontStyle: 'italic'}}>
      {name}
    </li>
  );
}
```

## keyの指定
`map`内でJSX要素を使用する場合は`key`が必要
```js
const people = [{
  id: 0,
  name: 'Creola Katherine Johnson',
  profession: 'mathematician',
}, {
  id: 1,
  name: 'Mario José Molina-Pasquel Henríquez',
  profession: 'chemist',
}, {
  id: 2,
  name: 'Mohammad Abdus Salam',
  profession: 'physicist',
}, {
  name: 'Percy Lavon Julian',
  profession: 'chemist',  
}, {
  name: 'Subrahmanyan Chandrasekhar',
  profession: 'astrophysicist',
}];

export default function List() {
  const listItems = people.map(person =>
    <li key={person.id}>{person}</li>
  );
  return <ul>{listItems}</ul>;
}
```

コンポーネントを複数レンダリングする際は、コンポーネントから返されるタグに`key`を渡すのではなく、コンポーネントに`key`を渡す
`Recipe`コンポーネントに対して`key`をpropsとしては渡せない。

```js
import { recipes } from './data.js';

function Recipe({ id, name, ingredients }) {
  return (
    <div>
      <h2>{name}</h2>
      <ul>
        {ingredients.map(ingredient =>
          <li key={ingredient}>
            {ingredient}
          </li>
        )}
      </ul>
    </div>
  );
}

export default function RecipeList() {
  return (
    <div>
      <h1>Recipes</h1>
      {recipes.map(recipe =>
        <Recipe {...recipe} key={recipe.id} />
      )}
    </div>
  );
}
```

## <Fragment>構文
複数のDOMノードを渡す必要がある場合、<>..</>では`key`を渡せないため、より明示的な<Fragment>構文を渡す必要がある。

```js
import { Fragment } from 'react';
.
.
const listItems = people.map(person =>
  <Fragment key={person.id}>
    <h1>{person.name}</h1>
    <p>{person.bio}</p>
  </Fragment>
);
```

## イベントハンドラ関数

- `handle`というワードが先頭につく
- コンポーネント内部で定義される

```js
export default function Button() {
  function handleClick() {
    alert('You clicked me!');
  }

  return (
    <button onClick={handleClick}>
      Click me
    </button>
  );
}
```

JSX内でインラインで定義することもできる。

```js
export default function Button() {
  return (
    <button onClick={function handleClick() {
      alert('You clicked me!')
    }}>
      Click me
    </button>
  );
}
```

またアロー関数で簡略化することも可能

```js
export default function Button() {
  return (
    <button onClick={() => {
      alert('You clicked me!')
    }}>
      Click me
    </button>
  );
}
```
