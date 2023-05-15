class Item < ApplicationRecord
  has_many :orders
  has_many :members, through: :orders

  has_many :items_keywords
  has_many :keywords, through: :items_keywords

  belongs_to :category

  has_many :orders_items
  has_many :orders, through: :orders_items
  has_many :logs

  validates :name, presence: true
  validates :category, presence: true

  def add_keywords(keyword_array)
  	keyword_array.split(",").reject(&:blank?).each(&:strip!).each do |keyword|
      self.keywords << Keyword.find_or_create_by(name: keyword.downcase)
    end
  end

  def category_name
    category.name
  end
end
