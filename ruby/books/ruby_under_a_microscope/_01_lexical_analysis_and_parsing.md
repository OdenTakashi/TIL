## Rubyのしくみ -Ruby Under a Microscope- まとめ01
- プログラムを実行する前にRubyは3回コードを読んでいる
1. Rubyコード
2. 字句解析
- ソースコード内のテキストを読み込み、Rubyで使われる単語の列、トークン配列へと変換
3. 構文解析
- トークン列をRubyの構文として意味のある単位にグループ化する
4. コンパイル
- その構文を仮想マシンが実行できる低レベルの命令へとコンパイルする
5. YARV命令

## 字句解析
- 文字の並びを解析して意味のあるトークンに変換
```rb
10.times do |n|
  puts n
end
irb(main):008> Prism.lex('10.times do |n|puts n end')
=>
#<Prism::LexResult:0x00000001085746b8
 @comments=[],
 @data_loc=nil,
 @errors=[],
 @magic_comments=[],
 @source=
  #<Prism::ASCIISource:0x000000010830e068
   @offsets=[0],
   @source="10.times do |n|puts n end",
   @start_line=1>,
 @value=
  [[INTEGER(1,0)-(1,2)("10"), 2],
   [DOT(1,2)-(1,3)("."), 256],
   [IDENTIFIER(1,3)-(1,8)("times"), 16],
   [KEYWORD_DO(1,9)-(1,11)("do"), 1],
   [PIPE(1,12)-(1,13)("|"), 1025],
   [IDENTIFIER(1,13)-(1,14)("n"), 16],
   [PIPE(1,14)-(1,15)("|"), 1025],
   [IDENTIFIER(1,15)-(1,19)("puts"), 32],
   [IDENTIFIER(1,20)-(1,21)("n"), 1026],
   [KEYWORD_END(1,22)-(1,25)("end"), 2],
   [EOF(1,25)-(1,25)(""), 2]],
```

### メモ
- VMを使っているのOS環境の抽象化のため?
