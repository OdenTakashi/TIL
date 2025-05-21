# eks
- controll plane をベンダー側で管理できる
- data plane は EC2, fargate

## podスケーリング
- 水平
  - CPU利用率が50%になるようにスケール
- 垂直

## Nodeスケーリング
- pod増やそうとしたが、入れない場合NodeがEC2を立ててくれる