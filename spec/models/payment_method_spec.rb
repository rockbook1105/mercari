# == Schema Information
#
# Table name: payment_methods
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payjp_customer_id :string(255)      not null
#  user_id           :bigint(8)        not null
#
# Indexes
#
#  index_payment_methods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe 'Validations' do
    it 'is valid' do
      expect(build(:payment_method)).to be_valid
    end

    describe 'Presence' do
      it 'is invalid without payjp_customer_id' do
        payment_method = build(:payment_method, payjp_customer_id: nil)
        payment_method.valid?
        expect(payment_method.errors.messages[:payjp_customer_id]).to include("を入力してください")
      end

      it 'is invalid without user_id' do
        payment_method = build(:payment_method, user_id: nil)
        payment_method.valid?
        expect(payment_method.errors.messages[:user]).to include("を入力してください")
      end
    end

    describe 'Uniqueness' do
      it 'is invalid when payjp_customer_id is already taken' do
        payment_method = create(:payment_method)
        duplicated_payment_method = build(:payment_method)
        duplicated_payment_method.valid?
        expect(duplicated_payment_method.errors.messages[:payjp_customer_id]).to include("はすでに存在します")
      end
    end
  end
end
