json.array!(@merchant_accounts) do |merchant_account|
  json.extract! merchant_account, :id, :account_id, :merchant_id, :branch_id, :current_warehouse_id
  json.url merchant_account_url(merchant_account, format: :json)
end
