class Product < ActiveRecord::Base
  #Add quan he
  has_many :export_details
  has_many :inventory_details
  has_many :order_details
  has_many :return_details
  belongs_to :provider
  belongs_to :warehouse
  belongs_to :import
  belongs_to :skull

  #Bat loi View
  #validates_presence_of :product_code, :provider, :warehouse, :import, :name, :import_quality, :import_price, :import_id
  #validates_numericality_of :warehouse_id, message: "nhap so"

  private
  def self.search(search)
    where(merchant_id LIKE 1).where('name LIKE ?' , "%#{search}%")
  end


end