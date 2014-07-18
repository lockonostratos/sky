class MerchantAccountPermission < ActiveRecord::Base


  belongs_to :merchant_account
  belongs_to :permission
  
end