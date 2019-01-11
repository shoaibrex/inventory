class Keyword < ApplicationRecord
	has_many :items_keywords
	has_many :items, through: :items_keywords
end
