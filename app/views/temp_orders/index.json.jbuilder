json.array!(@temp_orders) do |temp_order|
  json.extract! temp_order, :id, :branch_id, :warehouse_id, :customer_id, :merchant_account_id, :sales_account_id, :name, :return, :payment_method, :delivery, :bill_discount, :total_price, :discount_voucher, :discount_cash, :final_price, :deposit, :currency_debit
  json.url temp_order_url(temp_order, format: :json)
end
