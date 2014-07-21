class ProductSerializer < ActiveModel::Serializer
  attributes :id, :product_code, :skull_id, :provider_id, :warehouse_id, :import_id, :name, :import_quality, :available_quality, :instock_quality, :import_price, :expire
end
