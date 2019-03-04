# == Schema Information
#
# Table name: authorizations
#
#  id         :bigint(8)        not null, primary key
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_authorizations_on_provider_and_uid  (provider,uid) UNIQUE
#  index_authorizations_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Authorization < ApplicationRecord
  belongs_to :user

  validates :provider,
            :uid,
            presence: true

  validates :provider, uniqueness: { scope: :uid }

  def self.find_by_auth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.find_or_create_by_oauth(auth)
    authorization = find_by_auth(auth)
    if authorization
      authorization.user
    else
      find_or_create_user(auth)
    end
  end

  def self.find_or_create_user(auth)
    registered_user = User.find_by(email: auth.info.email)
    if registered_user
      Authorization.create!(provider: auth.provider, uid: auth.uid, user_id: registered_user.id)
      registered_user
    else
      user = User.create!(nickname: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0, 20])
      Authorization.create!(provider: auth.provider, uid: auth.uid, user_id: user.id)
      user
    end
  end
end
