# == Schema Information
#
# Table name: product_images
#
#  id         :bigint(8)        not null, primary key
#  image      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint(8)
#
# Indexes
#
#  index_product_images_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#

class ProductImage < ApplicationRecord
  belongs_to :product

  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
