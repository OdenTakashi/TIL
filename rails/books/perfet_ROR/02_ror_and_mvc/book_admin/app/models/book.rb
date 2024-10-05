class Book < ApplicationRecord
  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about,  ->(theme) { where("name like ?", "%#{theme}%") }
  scope :find_price, ->(price) { where(find_by(price:)) }

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :name, :include_exercise_word

  def include_exercise_word
    if name.include?("exercise")
      errors.add(:name, "I don't like exercise")
    end
  end
end
