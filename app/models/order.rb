class Order < ApplicationRecord
  has_many :order_items, inverse_of: :order, dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
	has_many :items, through: :order_items, dependent: :destroy
end
