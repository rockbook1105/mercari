
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
