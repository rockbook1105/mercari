# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  nickname               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid' do
      expect(build(:user)).to be_valid
    end

    describe 'Presence' do
      it 'is invalid without email' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors.messages[:email]).to include("を入力してください")
      end

      it 'is invalid without nickname' do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors.messages[:nickname]).to include("を入力してください")
      end

      context 'when password is required' do
        before { allow_any_instance_of(User).to receive(:password_required?).and_return(true) }

        it 'is invalid without password' do
          user = build(:user, password: nil)
          user.valid?
          expect(user.errors.messages[:password]).to include("を入力してください")
        end
      end

      context 'when password is not required' do
        before { allow_any_instance_of(User).to receive(:password_required?).and_return(false) }

        it 'is valid without password' do
          user = build(:user, password: nil)
          expect(user).to be_valid
        end
      end
    end

    describe 'Uniqueness' do
      it 'is invalid when email is already taken' do
        user = create(:user, email: "hogehoge@hoge.com")
        duplicated_user = build(:user, email: "hogehoge@hoge.com")
        duplicated_user.valid?
        expect(duplicated_user.errors.messages[:email]).to include("はすでに存在します")
      end

      it 'is invalid when nickname is already taken' do
        user = create(:user, nickname: "KEISUKEHONDA")
        duplicated_user = build(:user, nickname: "KEISUKEHONDA")
        duplicated_user.valid?
        expect(duplicated_user.errors.messages[:nickname]).to include("はすでに存在します")
      end
    end

    describe 'Format' do
      it 'is invalid without @' do
        user = build(:user, email: "hogehoge.com")
        user.valid?
        expect(user.errors.messages[:email]).to include("は不正な値です")
      end
    end
  end
end
