# ソフトウェアアーキテクチャの基礎 -エンジアリングに基づく体系的なアプローチ-
- Mark Richards, Near Ford 著
- 島田浩二 訳

## アーキテクチャ特性の(部分的な)リスト
- コードベースから運用まで幅広いスコープを持っている
  - モジュール性から ~ 弾力性
- 大まかなカテゴライズがされる

### アーキテクチャの運用特性
- 可用性(Availabirity)
  - システムがどれだけの期間利用できるか
- 継続性(Continuity)
  - 障害復旧能力
- パフォーマンス
  - ストレステスト、ピーク分析、使用頻度、容量、応答時間分析
- 回復性(Recoverability)
  - 処理の持続性要件
  - 災害時どれだけオンラインに戻すかなど
- 信頼性/安全性(Reliability/Safety)
  - システムが人命に影響を与えないか
  - 障障害が発生した際コストが嵩まないか
- 堅牢性(Robustness)
  - インターネットが接続分断された際、エラー処理や強がが化ができるか
- スケーラビリティ(Scalability)
  - ユーザー数、リクエスト数が増えてもシステムが動作するかどうか

### アーキテクチャの構造特性
- 構成容易性
  - エンドユーザーがUIから設定をいかに観点にできるかどうか
- 拡張性
  - プラグイン追加可能にすることをどれだけ重視するか
- インストール容易性
  - プラットフォームごとにいかに簡単にインストールできるか
- 活用性/再利用性
  - 複数製品で再利用できるか
- ローカライゼーション
  - 多言語対応できているか
- メンテナンス容易性
  -　変更の適用、システム拡張が簡単に行えるか
- 可搬性
  - 複数プラットフォームで動くかどうか
- アップグレード容易性
  - アップグレードが簡単、迅速に行えるかどうか

### アーキテクチャの横断的特性
- アクセシビリティ
  - すべてのユーザーががアクセスできるか
- 長期保存性
  - データは一定期間後削除orアーカイブされるか
- 認証
- 認可
- 合法性
  - どの法律に則ってアプリを運用しているか、会社はどどんな権利を持っているか
- プライバシー
  - 従業員から取引を隠せているか
- セキュリティ
  - DB内のデータは暗号化する必要があるか、社内システム間の通信は暗号化される必要があるか
- サポート容易性
  - アプリの技術的サポートはどれだけ必要か
- ユーザービリティ/達成容易性
  - ユーザーが解決したい問題二リーチするハードル
- 相互運用性
  - 他システムとの統合容易性、API公開などが必要
- 互換性
  - ドメイン、業界の標準を重視
- 学習容易性
  - そのシステムを使いこなすのにどれだけ時間がかかるか
