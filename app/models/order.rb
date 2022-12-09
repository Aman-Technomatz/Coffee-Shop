class Order < ApplicationRecord
	has_many :order_items, inverse_of: :order, dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
	has_many :items, through: :order_items, dependent: :destroy
	after_save :save_grand_total

	# calculate save_grand_total
	def save_grand_total
    total = order_items.sum(:total_price)
		return if grand_total == total

    # total = order_items.sum(:total_price)
		update(grand_total: total)
	end
end
