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

class PurchaseHistory < ApplicationRecord
  belongs_to :purchaser, class_name: "User", foreign_key: :purchaser_id
  belongs_to :product

  validates :payjp_charge_id, presence: true
end
