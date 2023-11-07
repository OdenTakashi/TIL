# Error
Rubyでは全ての例外エラーの親が'Exception'クラスを持つ
通常のプログラムで発生する可能性の高いエラーとしてStandardErrorがある。
StandarErrorを継承していないエラーとも存在する。

以下がStandardErrorを継承しているエラー
```rb
ArgumentError
EOFError
EncodingError
FiberError
FloatDomainError
IOError
IndexError
KeyError
LocalJumpError
NameError
NoMethodError
RangeError
RegexpError
RuntimeError
StandardError
StopIteration
SystemCallError
ThreadError
TypeError
ZeroDivisionError
```
以下がStandarErrorを継承していないエラー
```rb
Exception
Interrupt
LoadError
NoMemoryError
NotImplementedError
ScriptError
SecurityError
SignalException
SyntaxError
SystemExit
SystemStackError
```

## 複数のエラーを捕捉したい時

```rb

begin
  # `KeyError`と`StopIteration`が発生する処理
rescue KeyError

rescue StopIteration

end

begin
  # `KeyError`と`StopIteration`が発生する処理
rescue KeyError, StopIteration

end

begin
  # `KeyError`と`StopIteration`が発生する処理
rescue *[KeyError, StopIteration]

end
```
