# Javascript
## デフォルトエクスポートvs名前付きエクスポート
値をエクスポートする主な方法

| 構文 | Export文 | Import文 | ファイルごとに置ける数 |
| --- | --- | --- | --- |
| Default | export default function Button() {} | import Button from './Button.js' | １ |
| Named | export function  Button() {} | import { Button } from './Button.js' | 制限なし |

デフォルトインポートの場合は`import`の後に好き名前を置ける
名前付きインポートの場合は`import`の後の名前が、エクスポート側と合致している必要あり

## 純関数
計算だけを行い、他には何もしない関数
- 呼び出される前に存在していたオブジェクトや変数は変更しない
- 同じ入力を与えると、常に同じ結果を返す

以下は純関数

```js
function double(number) {
  return 2 * number;
}
```

