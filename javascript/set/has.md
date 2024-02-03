# hasメソッド

- 指定された値が集合の中にあるかどうか真偽値を返す
- Array#includesよりも圧倒的に早い
  - レコードを一気に見るため

```js
const set1 = new Set([1, 2, 3, 4, 5]);

console.log(set1.has(1));
=> true
```


## 参考
- https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Set/has
