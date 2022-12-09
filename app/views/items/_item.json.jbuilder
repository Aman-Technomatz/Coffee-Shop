json.extract! item, :id, :name, :price, :tax_percent, :discount, :availability, :created_at, :updated_at
json.url item_url(item, format: :json)
