json.array!(@orders) do |order|
  json.extract! order, :id, :branch_id, :warehouse_id,:name, :merchant_account_id, :customer_id, :return, :delivery, :total_price, :deposit, :discount_cash, :final_price, :payment_method, :status
  json.url order_url(order, format: :json)
end
