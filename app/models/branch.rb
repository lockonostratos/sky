class Branch < ActiveRecord::Base
  has_many :warehouses
  has_many :orders
  has_many :merchant_accounts
  belongs_to :merchant

  after_create :create_default_warehouse

  private
  def create_default_warehouse
    Warehouse.create!({merchant_id:self.merchant_id, branch_id:self.id, name: 'KHO 01'})
  end
end