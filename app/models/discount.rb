class Discount < ApplicationRecord
  belongs_to :base_item, class_name: 'Item', foreign_key: 'base_item_id'
  belongs_to :child_item, class_name: 'Item', foreign_key: 'child_item_id'
end
