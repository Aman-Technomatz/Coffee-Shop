class TaxCategory < ApplicationRecord
  has_many :item, dependent: :destroy
end
