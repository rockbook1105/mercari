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

require 'rails_helper'

RSpec.describe ProductImage, type: :model do
  describe "Validations" do
    it "is valid" do
      expect(build(:product_image)).to be_valid
    end

    describe "presence" do
      it "is invalid without image" do
        expect(build(:product_image, image: nil)).to be_invalid
      end
    end
  end
end
