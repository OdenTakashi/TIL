# 設計工程とデータベース
## データベース設計が重要な理由
- システムの大半のデータはDBに保持されるため
- アプリとはいわばデータの流通機構であるため、どのようなデータをどういうフォーマットで持つかによって、必要なプログラムが変わってくるため

## DOA(Data Oriented Approach)とPOA(Process Oriented Approach)
DOA: データ -> プログラム
  - データは永続。複数プロセスで共有可能
POA: プログラム -> データ
  - 業務プロセスは高頻度で変わっていく
  - プロセスごとに重複するデータなど生まれる、ex. 受注、発注で別データを持つ -> データの重複が生まれる

最初にデータがあり、その次にプログラムがある。
DBはシステムの中心。

## 3層スキーマ
スキーマ: データ構造、format

スキーマは一般的に以下の3つに分けることができる
- 外部スキーマ
- 概念スキーマ
- 内部スキーマ

### 外部スキーマ
Userが見える形でのデータ。
ex. ECサイトなどで何を、何個、いつ注文したか見える状態。データ構造

### 概念スキーマ
外部スキーマの重複をなくし、正規化したもの。
外部スキーマと内部スキーマの緩衝材。

### 内部スキーマ
概念スキーマを実際にデータに置き換えたもの。

概念の有用性がわからない場合は、それはなかったどうなるかを考えみる