require 'rails_helper'

RSpec.describe PayjpCardForm, type: :model do
  let(:valid_card_form) { build(:payjp_card_form) }
  let(:expired_card_form) { build(:payjp_card_form, exp_year: 2000) }
  let(:user) { create(:user) }

  describe 'Validations' do
    describe 'Presence' do
      it 'is invalid without cvc' do
        payjp_card_form = build(:payjp_card_form, cvc: nil)
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:cvc]).to include("を入力してください")
      end

      it 'is invalid without exp_month' do
        payjp_card_form = build(:payjp_card_form, exp_month: nil)
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:exp_month]).to include("を入力してください")
      end

      it 'is invalid without exp_year' do
        payjp_card_form = build(:payjp_card_form, exp_year: nil)
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:exp_year]).to include("を入力してください")
      end

      it 'is invalid without number' do
        payjp_card_form = build(:payjp_card_form, number: nil)
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:number]).to include("を入力してください")
      end
    end

    describe 'Length' do
      it 'is invalid when cvc length value is smaller than 3' do
        payjp_card_form = build(:payjp_card_form, cvc: "12")
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:cvc]).to include("は3文字以上で入力してください")
      end

      it 'is invalid when cvc length value is bigger than 4' do
        payjp_card_form = build(:payjp_card_form, cvc: "12345")
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:cvc]).to include("は4文字以内で入力してください")
      end

      it 'is invalid when exp_month length is not equal to 2' do
        payjp_card_form = build(:payjp_card_form, exp_month: "1")
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:exp_month]).to include("は2文字で入力してください")
      end

      it 'is invalid when exp_year length is not equal to 4' do
        payjp_card_form = build(:payjp_card_form, exp_year: "123")
        payjp_card_form.valid?
        expect(payjp_card_form.errors.messages[:exp_year]).to include("は4文字で入力してください")
      end
    end

    describe 'Format' do
      context 'with valid value' do
        it 'is valid' do
          expect(build(:payjp_card_form, number: 14_000_000_000_000)).to be_valid
          expect(build(:payjp_card_form, number: 150_000_000_000_000)).to be_valid
          expect(build(:payjp_card_form, number: 1_600_000_000_000_000)).to be_valid
        end
      end

      context 'with invalid value' do
        it 'is invalid when number is less than 14 digits' do
          payjp_card_form = build(:payjp_card_form, number: 1_300_000_000_000)
          payjp_card_form.valid?
          expect(payjp_card_form.errors.messages[:number]).to include("は不正な値です")
        end

        it 'is invalid when number is more than 16 digits' do
          payjp_card_form = build(:payjp_card_form, number: 17_000_000_000_000_000)
          payjp_card_form.valid?
          expect(payjp_card_form.errors.messages[:number]).to include("は不正な値です")
        end

        it 'is invalid when number value contains non-numetric characters' do
          payjp_card_form = build(:payjp_card_form, number: "1400000000000a")
          payjp_card_form.valid?
          expect(payjp_card_form.errors.messages[:number]).to include("は不正な値です")
        end
      end
    end

    describe '#not_expired' do
      context 'when expiration date of the card is not coming yet' do
        it 'is valid' do
          expect(valid_card_form).to be_valid
        end
      end

      context 'when the card already exipires' do
        it 'is invalid' do
          expect(expired_card_form).to be_invalid
        end
      end
    end
  end

  describe '#save' do
    context 'with valid attributes' do
      it 'creates payment_method record' do
        expect { valid_card_form.save(user) }.to change { PaymentMethod.count }.by(1)
      end
    end
    context 'with invalid attributes' do
      it 'does not create payment_method record' do
        expect { expired_card_form.save(user) }.not_to change { PaymentMethod.count }
      end
    end
  end
end
