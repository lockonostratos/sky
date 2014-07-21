class Role < ActiveRecord::Base
  has_and_belongs_to_many :modules
  has_many :merchant_account_roles
  has_many :role_permissions
  has_many :merchant_account_permission_details
  has_many :role_warehouses

end