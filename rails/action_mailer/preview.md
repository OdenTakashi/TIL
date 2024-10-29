## プレビュー機能
以下のようにwelcomeメソッドをuser_mailerに実装を行い
```rb
class UserMailer < ApplicationMailer
  def welcome
    @name = params[:name]
    mail(to: params[:to], subject: "登録完了")
  end
end
```

viewも用意

```rb
# app/views/user_mailer/welcome.html.erb 
<%= @name %> 様
ユーザー登録が完了しました。

# app/views/user_mailer/welcome.text.erb
<p> <%= @name %> 様 </p>
ユーザー登録が完了しました。
```

その後文面をtest的に見たい際には、以下のようにtest/mailers/previews/user_mailer_preview.rb配下で実装を行うとローカル環境でメール文面を確認できる
localhost:3000/rails/mailers/user_mailer/welcomeにアクセスすることで確認できる
```rb
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.with(to: "oden@example.com", name: "oden").welcome
  end
end
```
