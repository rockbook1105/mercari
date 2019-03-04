# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer          not null
#
# Indexes
#
#  index_categories_on_parent_id  (parent_id)
#

FactoryBot.define do
  factory :category do
    
  end
end
