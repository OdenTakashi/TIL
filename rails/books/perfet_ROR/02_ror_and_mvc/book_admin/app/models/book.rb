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

  before_validation :add_lovely_to_cat
  after_destroy do
    Rails.logger.info "Book is deleted: #{self.attributes}"
  end

  after_destroy if: :high_price? do
    Rails.logger.info "Book with high price is deleted #{self.attributes}"
    Rails.logger.warn "Please check!!"
  end

  enum sales_status: {
    reservation: 0,
    now_on_sale: 1,
    end_of_print: 2
  }

  def high_price?
    price >= 5000
  end

  def add_lovely_to_cat
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end

  def include_exercise_word
    if name.include?("exercise")
      errors.add(:name, "I don't like exercise")
    end
  end
end
