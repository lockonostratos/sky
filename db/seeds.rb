# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Tạo tài khoản của chính Gera
Account.create(:email=>'Gera',
               :password=>'12345',
               :password_confirmation=>'12345',
               :account_type=>1,
               :headquater=>1)
#Tạo tài khoản Merchant
merchant = Account.create(:email=>'Sang',
                          :password=>'1234',
                          :password_confirmation=>'1234',
                          :account_type=>5)
merchant_user = Account.create(:email=>'Loc',
                               :password=>'1234',
                               :password_confirmation=>'1234',
                               :account_type=>6,
                               :parent_id=>merchant.id,
                               :headquater=>merchant.id)
Account.create(:email=>'ky',
               :password=>'1234',
               :password_confirmation=>'1234',
               :account_type=>6,
               :parent_id=>merchant.id,
               :headquater=>merchant.id)
Account.create(:email=>'quyen',
               :password=>'1234',
               :password_confirmation=>'1234',
               :account_type=>6,
               :parent_id=>merchant_user.id,
               :headquater=>merchant_user.headquater)