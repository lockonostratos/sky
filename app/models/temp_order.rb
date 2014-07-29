class TempOrder < ActiveRecord::Base
  has_many :temp_order_details

  belongs_to :branch
  belongs_to :warehouse
  belongs_to :merchant_account
  belongs_to :customer
end