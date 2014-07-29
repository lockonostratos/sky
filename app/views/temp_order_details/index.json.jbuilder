json.array!(@temp_order_details) do |temp_order_detail|
  json.extract! temp_order_detail, :id, :order_id, :product_id, :quality, :price, :discount_cash, :discount_percent, :total_amount
  json.url temp_order_detail_url(temp_order_detail, format: :json)
end
