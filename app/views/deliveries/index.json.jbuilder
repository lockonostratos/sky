json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :order_id, :merchant_account_id, :success, :creation_date, :delivery_date, :delivery_address, :contact_name, :contact_phone, :transportation_fee, :comment, :status
  json.url delivery_url(delivery, format: :json)
end
