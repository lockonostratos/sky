class ProductSummarySerializer < ActiveModel::Serializer
  attributes :id, :product_code, :skull_id, :warehouse_id, :name, :merchant_account_id, :quality, :price
end
