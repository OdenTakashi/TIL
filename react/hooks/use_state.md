# useState

```js
const [value, setValue] = useState(null)
```

`value`には指定したStringが入る
`setValue`には`value`を更新する関数が入る

- コンポーネントのトップレベルでのみ定義することができる

以下のコードはフックをreturnの後で定義しているためエラーが発生する

```js
import { useState } from 'react';

export default function FeedbackForm() {
  const [isSent, setIsSent] = useState(false);

  if (isSent) {
    return <h1>Thank you!</h1>;
  } else {
    return (
      const [message, setMessage] = useState('');

      <form onSubmit={e => {
        e.preventDefault();
        alert(`Sending: "${message}"`);
        setIsSent(true);
      }}>
        <textarea
          placeholder="Message"
          value={message}
          onChange={e => setMessage(e.target.value)}
        />
        <br />
        <button type="submit">Send</button>
      </form>
    );
  }
}
```

```
Error
Lint Error
9:35 - React Hook "useState" is called conditionally. React Hooks must be called in the exact same order in every component render. Did you accidentally call a React Hook after an early return?
```

以下の理由に`return`文の前にstateを追加する必要がある。

```js
import { useState } from 'react';

export default function FeedbackForm() {
  const [isSent, setIsSent] = useState(false);
  const [message, setMessage] = useState('');

  if (isSent) {
    return <h1>Thank you!</h1>;
  } else {
    return (
      <form onSubmit={e => {
        e.preventDefault();
        alert(`Sending: "${message}"`);
        setIsSent(true);
      }}>
        <textarea
          placeholder="Message"
          value={message}
          onChange={e => setMessage(e.target.value)}
        />
        <br />
        <button type="submit">Send</button>
      </form>
    );
  }
}
```

## stateが更新されるタイミング

以下の例の場合、stateが更新されるのは次のレンダーのタイミング
そのため、`setNumber(0 + 1)`という処理が3回行われる

```js
import { useState } from 'react';

export default function Counter() {
  const [number, setNumber] = useState(0);

  return (
    <>
      <h1>{number}</h1>
      <button onClick={() => {
        setNumber(number + 1);
        setNumber(number + 1);
        setNumber(number + 1);
      }}>+3</button>
    </>
  )
}
```

## stateは読み取り専用として扱う
`state`は書き換えるべきではない
理由として、`state`セット関数が使用されないとReactは変更を認識できないため
-> レンダーがトリガーされない

以下の例では`state`を直接置き換えているが、レンダーがトリガーされないため再描画がされない

```js
import { useState } from 'react';

export default function MovingDot() {
  const [position, setPosition] = useState({
    x: 0,
    y: 0
  });

  return (
    <div
      onPointerMove={e => {
        position.x = e.clientX;
        position.y = e.clientY;
      }}
      style={{
        position: 'relative',
        width: '100vw',
        height: '100vh',
      }}>
  )
}
```

以下のように`state`セット関数を用いて、新しいオブジェクトで置き換える必要がある

```js
<div
  onPointerMove={e => {
    x: e.clientX;
    y: e.clientY;
  }}
>
```

`push()`のように配列自体を変えてしまう方法は好ましくない

```js
import { useState } from 'react';

let nextId = 0;

export default function List() {
  const [name, setName] = useState('');
  const [artists, setArtists] = useState([]);

  return (
    <>
      <h1>Inspiring sculptors:</h1>
      <input
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <button onClick={() => {
        artists.push({
          id: nextId++,
          name: name,
        });
      }}>Add</button>
      <ul>
        {artists.map(artist => (
          <li key={artist.id}>{artist.name}</li>
        ))}
      </ul>
    </>
  );
}
```

代わりとして新たな配列を用意し、更新するという手段が有効

```js
import { useState } from 'react';

let nextId = 0;

export default function List() {
  const [name, setName] = useState('');
  const [artists, setArtists] = useState([]);

  return (
    <>
      <h1>Inspiring sculptors:</h1>
      <input
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <button onClick={() => {
        artists.push({
          id: nextId++,
          name: name,
        });
      }}>Add</button>
      <ul>
        {artists.map(artist => (
          <li key={artist.id}>{artist.name}</li>
        ))}
      </ul>
    </>
  );
}
```

## 不要なstate変数

- 関連するstateをグループ化する

以下をような場合、2つの変数が常に同時に更新されるのであれば、単一のstate変数にまとめるべき

```js
// 2つのstate変数
const [x, setX] = useState(0);
const [y, setY] = useState(0);

// 単一のstate変数
const [position, setPosition] = useState({ x: 0, y: 0 });
```

- stateの矛盾を避ける

`isSending`,`isSent`といった同時にtrueになり得ないstate変数は避ける

- 冗長なstateは避ける

以下のような他のstate変数から導き出せるようなstate変数は冗長

```js
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [fullName, setFullName] = useState('');
```

以下のように導ける

```js
 const fullName = firstName + ' ' + lastName;
```

- state内の重複を避ける

state間で重複があると、2箇所で更新をしなくてはいけない
片方のstateが更新された場合、もう片方に反映されない
-> 独立したstate構造を考える必要がある

stateの更新は書き換えるのではなく、別オブジェクトとして置き換える点も注意

- 深くネストされたstateを避ける

## propsをstateにコピーしない

以下のようにpropsをstate変数で初期化している場合は、propsが更新された場合stateが更新されない

```js
function Message({ messageColor }) {
  const [color, setColor] = useState(messageColor);
  .
  .
}
```

そのため以下のようにローカル変数に置き換える必要がある

```js
function Message({ messageColor }) {
  const color = messageColor
  .
  .
}
```
