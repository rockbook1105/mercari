# == Schema Information
#
# Table name: sizes
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Size < ApplicationRecord
  has_many :categories
end
