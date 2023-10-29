# Here document
<<[(-|~)]["'`]識別子["'`]
.
.
識別子
## <<EOS

```rb
test = <<EOS
first
second
third
EOS

p test
#=> 'first\nsecond\nthird\n'
```

## <<-EOS
最終行の識別子をインデントできる、インデントは反映される

```rb
test = <<~EOS
	first
	second
	third

p test
#=> '	first\n	second\n	third\n'
```

## <<~EOS
最終行の識別子をインデントできる、インデントは削除

```rb
test = <<~EOS
	first
	second
	third
	EOS

p test
#=> 'first\nsecond\nthird'
```


