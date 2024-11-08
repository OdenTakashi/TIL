## 1-2 データベースのあれこれ

### データベースの代表的なモデル
#### リレーショナルデータベース(Relational Database: RDB)
二次元表

#### オブジェクト指向データベース(Object Oriented Databse: OODB)
データと操作をまとめてオブジェクトという単位で保存。<br>
ex. (odentakashi, Tokyo, 03-123-123, 電話をかける、メールを送る) -> これが一つのデータ

#### XMLデータベース(XML Database: XMLDB)
XML(HTMLのようにタグでデータを管理を行う言語)形式をWeb上のやり取りに利用する動きがあった<br>
これの形式でデータを扱うためのデータベース、階層構造のデータの扱いを得意とする(HRとかこれを使うのかな..??)
```xml
<address>
  <name>odentakashi</name>
  <prefecture>Tokyo</prefecture>
</address>
```

#### キー・バリュー型ストア(Key-Value Store: KVS)
key, valueでデータ型を表現<br>
単純なデータ問い合わせに特化、はいトラフィックのWebサービスで利用されることが多い、SQL結合のような複雑なデータ操作は苦手<br>
Redis, Valkeyなど<br>
ex. (odentakashi, Tokyo)(yamadaoden, Saitama)

#### ドキュメント型データベース
JSONでデータ保存、MongoDBなど<br>
データの階層、配列を直感的に定義<br>
ex. {member: [{name: 'oden', age: 45, height: 172}, {name: 'hoge', age: 44, height: 177}]}

#### 階層型データベース(Hierarchical Database)
木構造で表現するデータベース<br>
RDBの一世代データベース、RDBの普及に伴いあまり使われなくなった

KVS, ドキュメント型DB、グラフ構造を扱うグラフデータベースを総称してNoSQLと呼ぶ<br>
モデルが変わればformatも変わり、設計手法もことなる

### DBMSの違いは設計に影響するか?
しない、データベースモデルの違いは設計手法に影響を与えるが、モデルの実装方法であるDBMSの違いは設計に影響を与えない
しかし、機能面で違いがあるため多少の影響はある -> このような違いが生じる理由としてDBMSがモデルを十分に表現できていない

リレーショナルデータベース(RDBMS(Relation Database Management System))
