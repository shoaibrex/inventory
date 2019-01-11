class ItemsKeyword < ApplicationRecord
	belongs_to :item
	belongs_to :keyword
end
