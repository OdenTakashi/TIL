## 異常系, 正常系の定義
正常系は早期returnしたいので、validationメソッドの頭に定義
異常系は後ろに定義
-> 何が正常系で異常系の区別がつきやすい

```rb
# このように書くのではなく
def hoge_validation
  if xxx
    throw(:abort)
  end
end
# 以下のように書くと分かりやすい
def hoge_validation
  retrurn if xxx
  
  throw(:abort)
end
```

## メソッドの条件分岐にならってspecを書く
以下のようにメソッドに複数の条件がある場合を考える
```rb
def hogehoge
  if aaaa
  elsif bbbb
  elsif cccc
  end
end
```
spec上ではaaaa -> bbbb -> ccccの順番でspecを書いてあげると、可読性が上がる
