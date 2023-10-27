Rails7 + importmap-railsを使用する際のインストール方法

# cocoon
動的にフォームを増減させるための機能を提供するGem。
動的なフォームを実現のためにフロントエンドとバックエンドで対応する必要がある。
そのためcocoonは、フロントエンド側のnpmパッケージ、バックエンド側のGemを提供している。

## インストール
### Gemのインストール
```rb
# Gemfile

gem "cocoon"
```

```sh
$ bundle install
```

### npm パッケージインストール
Rails7で標準となったimportmap-railsを使っているので、npmパッケージをJavaScript CDNから利用します。
また、npmにもcocoonはありますが、jQuery依存のため、cocoon-js-vanillaを使います。

` config/importmap.rb`にピン付けを行います。

```sh
$ .bin/importmap pin cocoon-js-vanilla
```

```rb
# config/importmap.rb

pin "cocoon-js-vanilla", to: "https://ga.jspm.io/npm:cocoon-js-vanilla@1.3.0/index.js"
```

`app/javascript/application.js` で、 `cocoon-js-vanilla` をインポートする。

```js
// app/javascript/application.js

import "cocoon-js-vanilla"
```

## 参考
- [arielj/vanilla\-nested: Rails dynamic nested forms using vanilla JS]("https:///github.com/arielj/vanilla-nested")
- [Cocoon Gem in Ruby on Rails 7\. In this article, we are going to learn… \| by Rutik Patel \| Medium](https://rutikkpatel.medium.com/cocoon-gem-in-ruby-on-rails-7-784b00e06bc2)
- [CodeJudge/codejudge/config/importmap\.rb at b30008a2d9d2b33c9b49e2d6d265965f5a7c73ba · larenspear/CodeJudge](https://github.com/larenspear/CodeJudge/blob/b30008a2d9d2b33c9b49e2d6d265965f5a7c73ba/codejudge/config/importmap.rb#L8)
- [Rails 7: importmap\-rails gem README（翻訳）｜TechRacho by BPS株式会社](https://techracho.bpsinc.jp/hachi8833/2022_06_29/112183)
