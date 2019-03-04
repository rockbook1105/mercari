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

require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let!(:authorization) { create(:authorization) }

  describe 'Validations' do
    it 'is valid' do
      expect(authorization).to be_valid
    end

    describe 'Presence' do
      it 'is invalid without user_id' do
        invalid_authorization = build(:authorization, user_id: nil)
        invalid_authorization.valid?
        expect(invalid_authorization.errors.messages[:user]).to include("を入力してください")
      end

      it 'is invalid without provider' do
        invalid_authorization = build(:authorization, provider: nil)
        invalid_authorization.valid?
        expect(invalid_authorization.errors.messages[:provider]).to include("を入力してください")
      end

      it 'is invalid without uid' do
        invalid_authorization = build(:authorization, uid: nil)
        invalid_authorization.valid?
        expect(invalid_authorization.errors.messages[:uid]).to include("を入力してください")
      end
    end

    describe 'Uniqueness' do
      it 'is invalid when the combination of provider and uid is already taken' do
        duplicated_authorization = build(:authorization)
        duplicated_authorization.valid?
        expect(duplicated_authorization.errors.messages[:provider]).to include("はすでに存在します")
      end
    end
  end

  describe '.find_by_auth' do
    it 'returns Authorization instance based on auth.provider and auth.uid' do
      auth = OmniAuth::AuthHash.new(provider: "hoge", uid: 123_456_789)
      expect(Authorization.find_by_auth(auth)).to eq authorization
    end
  end

  describe '.find_or_create_by_oauth' do
    context 'when authorization exists' do
      it 'returns authorization.user' do
        auth = OmniAuth::AuthHash.new(provider: "hoge", uid: 123_456_789)
        expect(Authorization.find_or_create_by_oauth(auth)).to eq authorization.user
      end
    end

    context 'when authorization does not exist' do
      it 'calls find_or_create_user method' do
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 987_654_321)
        allow(Authorization).to receive(:find_or_create_user)
        Authorization.find_or_create_by_oauth(auth)
        expect(Authorization).to have_received(:find_or_create_user)
      end
    end
  end

  describe '.find_or_create_user' do
    let(:user) { create(:user) }

    context 'when user already registered' do
      it 'returns registered_user and creates new authorization' do
        info_hash = { email: user.email }
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 000_000_000, info: info_hash)
        expect { Authorization.find_or_create_user(auth) }.to change { Authorization.count }.by(1)
                                                          .and change { User.count }.by(0)
      end
    end

    context 'when user did not register yet' do
      it 'creates new authorization and user' do
        info_hash = { email: "fuga@fuga.com", nickname: "阿部幸一郎" }
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 000_000_000, info: info_hash)
        expect { Authorization.find_or_create_user(auth) }.to change { Authorization.count }.by(1)
                                                          .and change { User.count }.by(1)
      end
    end
  end
end
