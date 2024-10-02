class Book < ApplicationRecord
  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about,  ->(theme) { where("name like ?", "%#{theme}%") }
  scope :find_price, ->(price) { where(find_by(price:)) }

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors
end
