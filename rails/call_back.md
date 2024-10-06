## コールバック
### around_action
各Actionの前後で実行。
前後で実行されるため、前処理と後処理の間yieldで本来の処理を行う必要がある。
```rb
class BooksController < ApplicationController
.
.
  around_action :action_logger, only: [ :destroy ]
  def action_logger
    logger.info "around-before"
    yield
    logger.info "around_after"
  end
  .
  .
end
  ```
