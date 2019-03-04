# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_likes_on_product_id  (product_id)
#  index_likes_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Like, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
