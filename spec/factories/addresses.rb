# == Schema Information
#
# Table name: addresses
#
#  id               :bigint(8)        not null, primary key
#  block_number     :string(255)      not null
#  building_name    :string(255)
#  city             :string(255)      not null
#  family_name      :string(255)      not null
#  family_name_kana :string(255)      not null
#  first_name       :string(255)      not null
#  first_name_kana  :string(255)      not null
#  phone_number     :string(255)
#  prefecture       :string(255)      not null
#  zipcode          :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# FactoryBot.define do
#   factory :address do
#     user
#     block_number "道玄坂2丁目10番12号"
#     building_name "新大宗ビル3号館8階"
#     city "渋谷区"
#     family_name "田中"
#     family_name_kana "タナカ"
#     first_name "太郎"
#     first_name_kana "タロウ"
#     phone_number "080_1234_5678"
#     prefecture "東京都"
#     zipcode "150-0043"
#   end
# end
