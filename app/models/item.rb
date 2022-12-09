class Item < ApplicationRecord
  has_many :order_items, dependent: :destroy
  validates :name, presence: true
  scope :available, -> { where(availability: true)}
end
