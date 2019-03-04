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

# FactoryBot.define do
#   factory :payment_method do
#     user
#     payjp_customer_id "cus_0000000000000000000000000000"
#   end
# end
