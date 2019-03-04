# == Schema Information
#
# Table name: products
#
#  id                      :bigint(8)        not null, primary key
#  deliverable_days        :integer          not null
#  detail                  :text(65535)      not null
#  name                    :string(255)      not null
#  price                   :integer          not null
#  published               :boolean          default(TRUE), not null
#  purchased               :boolean          default(FALSE), not null
#  shipping_fee_charges_on :integer          not null
#  shipping_from           :string(255)      not null
#  shipping_method         :integer          not null
#  status                  :integer          default("unused")
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint(8)        not null
#
# Indexes
#
#  index_products_on_name     (name)
#  index_products_on_user_id  (user_id)
#

<<<<<<< HEAD
=======
#  published               :boolean          default(TRUE), not null
>>>>>>> master
#  purchased               :boolean          default(FALSE), not null
#  shipping_fee_charges_on :integer          not null
#  shipping_from           :string(255)      not null
#  shipping_method         :integer          not null
#  status                  :integer          default("unused")
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint(8)        not null
#
# Indexes
#
#  index_products_on_name     (name)
#  index_products_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "is valid" do
      expect(build(:product)).to be_valid
    end

    describe "presence" do
      it "is invalid without deliverable_days" do
        product = build(:product, deliverable_days: nil)
        product.valid?
        expect(product.errors.messages[:deliverable_days]).to include('を入力してください')
      end

      it "is invalid without detail" do
        product = build(:product, detail: nil)
        product.valid?
        expect(product.errors.messages[:detail]).to include('を入力してください')
      end

      it "is invalid without name" do
        product = build(:product, name: nil)
        product.valid?
        expect(product.errors.messages[:name]).to include('を入力してください')
      end

      it "is invalid without price" do
        product = build(:product, price: nil)
        product.valid?
        expect(product.errors.messages[:price]).to include('を入力してください')
      end

      it "is invalid without shipping_fee_charges_on" do
        product = build(:product, shipping_fee_charges_on: nil)
        product.valid?
        expect(product.errors.messages[:shipping_fee_charges_on]).to include('を入力してください')
      end

      it "is invalid without shipping_from" do
        product = build(:product, shipping_from: nil)
        product.valid?
        expect(product.errors.messages[:shipping_from]).to include('を入力してください')
      end

      it "is invalid without shipping_method" do
        product = build(:product, shipping_method: nil)
        product.valid?
        expect(product.errors.messages[:shipping_method]).to include('を入力してください')
      end
    end

    describe "price inclusion" do
      it "is valid" do
        expect(build(:product, price: 300)).to be_valid
        expect(build(:product, price: 9_999_999)).to be_valid
      end

      context "when price is less than 300" do
        it "is invalid" do
          product = build(:product, price: 299)
          product.valid?
          expect(product.errors.messages[:price]).to include('は一覧にありません')
        end
      end

      context "when price is more than 9_999_999" do
        it "is invalid" do
          product = build(:product, price: 10_000_000)
          product.valid?
          expect(product.errors.messages[:price]).to include('は一覧にありません')
        end
      end
    end
  end
end
