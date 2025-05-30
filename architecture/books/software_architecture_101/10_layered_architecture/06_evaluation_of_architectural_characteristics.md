# ソフトウェアアーキテクチャの基礎 -エンジアリングに基づく体系的なアプローチ-
- Mark Richards, Near Ford 著
- 島田浩二 訳

## アーキテクチャ特性の評価
- 主な強み: 全体的なコストの低さとシンプルさ
- システムが複雑になると運用コストが増加する

- デプロイ容易性とテスト容易性について:
  - 十分にサポートされていない
    - 小さい変更の際にもデプロイメントユニット全体の再デプロイを必要とする
    - 小さい変更を加える際には全体のテストを回す必要あり

信頼性に関するポイント:
- 分散アーキテクチャーが持つ課題を持っていない
  - ネットワークトラフィックに関する課題が存在しない
  - 大域幅の問題がない
  - レイテンシーに関連する課題が克服されている

- 弾力性: とても低い
- スケーラビリティ: とても低い
  - モノリスのため、特定の機能のみのスケールが難しい

- 耐障害性がとても低い
  - アプリ内の一部がクラッシュした際、全体に影響
  - 平均回復時間が長い