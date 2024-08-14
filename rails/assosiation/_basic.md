## アソシエーション
### 自己参照アソシエーションでの(child: self)の利用 

```rb
class A < ApplicationRecord
  has_many :children, class_name: 'A', foreign_key: 'child_id'
  belongs_to :parent, class_name: 'A', foreign_key: 'parent_id', optional: true

  def test
    A.where(child: self)
  end
end
```
