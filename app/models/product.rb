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

class Product < ApplicationRecord
  include JpPrefecture

  enum deliverable_days: { one_or_two_days: 0, two_or_three_days: 1, four_to_seven_days: 2 }
  enum shipping_fee_charges_on: { exhibitor: 0, purchaser: 1 }
  enum shipping_method: { undefined: 0, mercari: 1, yu_mail: 2, letter_pack: 3, ordinary_mail: 4, kuroneko_yamato: 5, yu_pack: 6, click_post: 7, yu_packet: 8 }
  enum status: { unused: 0, almost_unused: 1, used: 2, a_little_dirty: 3, dirty: 4 }
  has_many :likes
  belongs_to :user
  has_many :images, class_name: "ProductImage", dependent: :destroy
  has_one :purchase_history
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :price, inclusion: 300..9_999_999
  validates :deliverable_days,
            :detail,
            :name,
            :price,
            :shipping_fee_charges_on,
            :shipping_from,
            :shipping_method,
            presence: true

  jp_prefecture :shipping_from

  def separate_price(price)
    price.to_s(:delimited, delimiter: ",")
  end
end
