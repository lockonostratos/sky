# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# t.string :product_code, :null => false
# t.belongs_to :skull
# t.belongs_to :warehouse, :null => false
# t.belongs_to :merchant_account, :null => false
#
# t.string :name, :null => false
# t.integer :quality, :default => 0
# t.decimal :price, :presence => 15
#
# t.timestamps

#Tạo

#1.Tạo tài khoản của chính Gera
Account.create({extension: :gera, display_name: 'hongky', email: 'hongky@gmail.com', password: '123'})

loc = Account.create({extension: :merchant, display_name: 'locquoc', email: 'lelongking@gmail.com', password: '123'})

son = Account.create({parent_id: loc.id, extension: :merchant, display_name: 'sonle', email: 'lehaoson@gmail.com', password: '123'})
pham = Account.create({parent_id: son.id, extension: :merchant, display_name: 'tieupham', email: 'tieupham@gmail.com', password: '123'})
tKy = Account.create({})

hcm = Branch.create({name: 'HỒ CHÍ MINH', merchant_id: loc.headquater})

tehao = Account.create({parent_id: son.id, extension: :merchant, display_name: 'tehao', email: 'tehao@gmail.com', password: '123'})
khoHcm = Warehouse.find_by_branch_id(hcm.id)
tehao.find_merchant_account.move_to_warehouse(khoHcm.id)
#2.Tạo tài khoản:




# ProductSummary.create([
#   {product_code: '1234567890123', skull_id},
#   {}
# ])