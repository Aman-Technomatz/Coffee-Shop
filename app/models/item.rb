class Item < ApplicationRecord
  validates :name, presence: true
  has_many :order_items, dependent: :destroy
  belongs_to :tax_category
  has_one :discount, dependent: :destroy
  scope :available, -> { where(availability: true)}
end
