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

class Address < ApplicationRecord
  has_one :user

  validates :family_name,
            :first_name,
            :family_name_kana,
            :first_name_kana,
            :zipcode,
            :prefecture,
            :city,
            :block_number,
            presence: true

  def full_name
    family_name + first_name
  end
end
