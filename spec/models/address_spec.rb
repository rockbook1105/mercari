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

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validations' do
    it 'is valid' do
      expect(build(:address)).to be_valid
    end

    describe 'Presence' do
      it 'is invalid without family_name' do
        address = build(:address, family_name: nil)
        address.valid?
        expect(address.errors.messages[:family_name]).to include "を入力してください"
      end

      it 'is invalid without first_name' do
        address = build(:address, first_name: nil)
        address.valid?
        expect(address.errors.messages[:first_name]).to include "を入力してください"
      end

      it 'is invalid without family_name_kana' do
        address = build(:address, family_name_kana: nil)
        address.valid?
        expect(address.errors.messages[:family_name_kana]).to include "を入力してください"
      end

      it 'is invalid without first_name_kana' do
        address = build(:address, first_name_kana: nil)
        address.valid?
        expect(address.errors.messages[:first_name_kana]).to include "を入力してください"
      end

      it 'is invalid without zipcode' do
        address = build(:address, zipcode: nil)
        address.valid?
        expect(address.errors.messages[:zipcode]).to include "を入力してください"
      end

      it 'is invalid without prefecture' do
        address = build(:address, prefecture: nil)
        address.valid?
        expect(address.errors.messages[:prefecture]).to include "を入力してください"
      end

      it 'is invalid without city' do
        address = build(:address, city: nil)
        address.valid?
        expect(address.errors.messages[:city]).to include "を入力してください"
      end

      it 'is invalid without block_number' do
        address = build(:address, block_number: nil)
        address.valid?
        expect(address.errors.messages[:block_number]).to include "を入力してください"
      end

      it 'is invalid without user_id' do
        address = build(:address, user_id: nil)
        address.valid?
        expect(address.errors.messages[:user]).to include "を入力してください"
      end
    end
  end

  describe '#full_name' do
    it 'returns merged family_name and first_name' do
      address = build(:address, family_name: "君塚", first_name: "慈容")
      expect(address.full_name).to eq ("君塚慈容")
    end
  end
end
