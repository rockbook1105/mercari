# == Schema Information
#
# Table name: purchase_histories
#
#  id              :bigint(8)        not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  payjp_charge_id :string(255)      not null
#  product_id      :bigint(8)        not null
#  purchaser_id    :bigint(8)        not null
#
# Indexes
#
#  index_purchase_histories_on_product_id    (product_id)
#  index_purchase_histories_on_purchaser_id  (purchaser_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (purchaser_id => users.id)
#

require 'rails_helper'

RSpec.describe PurchaseHistory, type: :model do
  describe "Validations" do
    it "is valid" do
      expect(build(:purchase_history)).to be_valid
    end

    describe "Presence" do
      it "is invalid without payjp_charge_id" do
        purchase_history = build(:purchase_history, payjp_charge_id: nil)
        purchase_history.valid?
        expect(purchase_history.errors.messages[:payjp_charge_id]).to include("を入力してください")
      end

      it "is invalid without product_id" do
        purchase_history = build(:purchase_history, product: nil)
        purchase_history.valid?
        expect(purchase_history.errors.messages[:product]).to include("を入力してください")
      end

      it "is invalid without purchaser_id" do
        purchase_history = build(:purchase_history, purchaser: nil)
        purchase_history.valid?
        expect(purchase_history.errors.messages[:purchaser]).to include("を入力してください")
      end
    end
  end
end
