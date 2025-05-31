# Rubyのしくみ -Ruby Under a Microscope-
- Pat Shaughnessy 著
- 島田浩二, 角谷信太朗 共訳

## 構文解析: Rubyはどのようにコードを理解するか
- Rubyをビルドするタイミングで、Bisonを使って、文法ファイルであるparse.yからparse.cというパーサーコードを作成する
  - RubyがCで書かれているので手元で一度ビルドしてから出ないと実行できない
- 字句解析は、構文解析中に行われる
  - 構文解析中に必要になった際に字句解析が求めれる

### LALR構文解析アルゴリズムを理解する
- LALR(Look-Ahead, Left to right Rightmost derivation)