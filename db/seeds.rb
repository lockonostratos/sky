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
khoDongThap = Warehouse.find(loc.find_merchant_account.current_warehouse_id)
khoHcm = Warehouse.find_by_branch_id(hcm.id)
tehao.find_merchant_account.move_to_warehouse(khoHcm.id)
#2.Tạo tài khoản:

#3. Tạo Skull
loc_mer_acc = loc.find_merchant_account
skull_ao = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Áo', description:''})
skull_quan = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Quần', description:''})
skull_bo = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Bộ', description:''})
skull_chai = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Chai', description:''})
skull_ket = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Kết', description:''})
skull_thung = Skull.create({merchant_id:loc_mer_acc.merchant_id, merchant_account_id:loc_mer_acc.id, skull_code:'Thùng', description:''})
# #4. Tạo Provider
provider_hcm_q1 = Provider.create({merchant_id:loc_mer_acc.merchant_id, name:'Quận 1 - Hồ Chí Minh'})
provider_hcm_q2 = Provider.create({merchant_id:loc_mer_acc.merchant_id, name:'Quận 2 - Hồ Chí Minh'})
provider_hcm_q3 = Provider.create({merchant_id:loc_mer_acc.merchant_id, name:'Quận 3 - Hồ Chí Minh'})
provider_hcm_q4 = Provider.create({merchant_id:loc_mer_acc.merchant_id, name:'Quận 4 - Hồ Chí Minh'})
#3. Tạo Product
product_AoThung = Product.create({ product_code: '1234567891011', skull_id: skull_ao.id,provider_id: provider_hcm_q1.id,
                                   warehouse_id: khoDongThap.id, import_id:1, name: 'Áo Thung',
                                   import_quality:100, available_quality:100, instock_quality:100, import_price:20000 })
product_Bia333 = Product.create({ product_code: '1234567891012', skull_id: skull_chai.id,provider_id: provider_hcm_q2.id,
                                   warehouse_id: khoDongThap.id, import_id:1, name: 'Bia 333',
                                   import_quality:150, available_quality:150, instock_quality:150, import_price:25000 })
product_BiaTiger = Product.create({ product_code: '1234567891013', skull_id: skull_ket.id,provider_id: provider_hcm_q3.id,
                                   warehouse_id: khoDongThap.id, import_id:1, name: 'Bia Tiger',
                                   import_quality:10, available_quality:10, instock_quality:10, import_price:300000 })
product_ThuocSau = Product.create({ product_code: '1234567891014', skull_id: skull_thung.id,provider_id: provider_hcm_q1.id,
                                   warehouse_id: khoDongThap.id, import_id:1, name: 'Thuốc Sâu',
                                   import_quality:50, available_quality:50, instock_quality:50, import_price:500000 })
#4.Tạo ProductSummary
product_summary_AoThung = ProductSummary.create({product_code: '1234567891011', skull_id: skull_ao.id, warehouse_id: khoDongThap.id,
                                                merchant_account_id:loc_mer_acc.id, name: 'Áo Thung', quality:100, price:50000})
product_summary_Bia333 = ProductSummary.create({product_code: '1234567891012', skull_id: skull_ao.id, warehouse_id: khoDongThap.id,
                                                 merchant_account_id:loc_mer_acc.id, name: 'Bia 333', quality:150, price:250000})
product_summary_BiaTiger = ProductSummary.create({product_code: '1234567891013', skull_id: skull_ao.id, warehouse_id: khoDongThap.id,
                                                 merchant_account_id:loc_mer_acc.id, name: 'Bia Tiger', quality:10, price:350000})
product_summary_ThuocSau = ProductSummary.create({product_code: '1234567891014', skull_id: skull_ao.id, warehouse_id: khoDongThap.id,
                                                 merchant_account_id:loc_mer_acc.id, name: 'Thuốc Sâu', quality:50, price:750000})





# ProductSummary.create([
#   {product_code: '1234567890123', skull_id},
#   {}
# ])