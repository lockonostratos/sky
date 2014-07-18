class Merchant < ActiveRecord::Base
  has_many :merchant_accounts
  has_many :customers
  has_many :branches
  has_many :skulls
  has_many :providers
  has_many :warehouses
  has_many :merchant_areas


end