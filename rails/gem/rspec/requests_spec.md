# request spec
アプリケーションのHTTPリクエストをテストするためのRSpecの一部。
Request Specを使うとコントローラが正しく動作するかどうか、ルーティングが正しく設定されているか、適切なレスポンスが返されているかなどをエンドツーエンドで確認できる。

## deleteリクエストとletの遅延評価
遅延評価: let で定義された変数は、その変数が初めて呼び出されたときに評価される。
なので以下のような場合は、作成されるタイミング起因エラーを気をつける。
byはブロックで渡されたメソッドが走る前にchangeに渡されたメソッドを呼び、キャプチャします。
しかし以下の場合ブロック以前には、lotteryがないため(letは遅延評価のため)差分が0とみなされます。

```rb
  describe 'DELETE /lotteries/:id' do
    subject(:request_delete) { delete lottery_path(lottery) }

    let(:lottery) { create(:lottery) }

    it 'delete lottery successful' do
      expect { request_delete }.to change(described_class, :count).by(-1)
      expect(response).to have_http_status(:found)
    end
  end
```

このような場合は以下のように、`let!`(即時評価)を使いテスト前にオブジェクトが存在するようにします。

```rb
let!(:lottery) { create(:lottery) }
```

