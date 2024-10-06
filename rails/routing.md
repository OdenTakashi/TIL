## Routing
### member
以下のようにネストしたリソースに対して、memberを利用すると以下のように、特定のpublisherに対してdetailページを作成できる。

```rb
  resources :publishers do
    member do
      get "detail"
    end
  end

  # console
  detail_publisher GET    /publishers/:id/detail(.:format)
```

### collection
以下ではcollectionを利用するとpublisher全体に対してリソースを作成できる。
```rb
  resources :publishers do
    collection do
      get "search"
    end
  end
```
