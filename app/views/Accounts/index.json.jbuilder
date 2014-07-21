json.array!(@gera_accounts) do |gera_account|
  json.extract! gera_account, :id, :display_name, :login_name, :email, :phone, :status, :password
  json.url gera_account_url(gera_account, format: :json)
end
