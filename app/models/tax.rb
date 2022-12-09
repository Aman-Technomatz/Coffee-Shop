class Tax < ApplicationRecord
  has_many :item, dependent: :destroy
end
