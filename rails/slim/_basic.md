# slim
Railsで利用されるテンプレートエンジン
## buttonタグ
以下のようにbuttonタグを利用することができる
```rb
button
  | ボタン
```
buttonにはtype属性があり、デフォルトではsubmit属性が付与されている
-> クリックするとリクエストが送られる
それをしない場合はtype属性にbutton属性を付与させる

```rb
button [type='button']
```
