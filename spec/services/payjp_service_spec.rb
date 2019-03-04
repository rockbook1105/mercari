require 'rails_helper'

RSpec.describe PayjpService, type: :service do
  let(:payjp_card_form) { build(:payjp_card_form) }
  let(:token_response) do
    { id: "tok_XXXXXXXX" }
  end
  let(:customer_response) do
    { id: "cus_XXXXXXXX" }
  end
  let(:charge_response) do
    { id: "ch_XXXXXXXX" }
  end
  let(:hash_for_payjp_token) do
    { card: payjp_card_form.attributes }
  end

  before do
    allow(Payjp::Token).to receive(:create).and_return(token_response)
    allow(Payjp::Customer).to receive(:create).and_return(customer_response)
    allow(Payjp::Charge).to receive(:create).and_return(charge_response)
  end

  describe '.create_token' do
    it 'returns created token' do
      expect(PayjpService.create_token(hash_for_payjp_token)).to eq token_response
    end
  end

  describe '.create_customer' do
    it 'returns created customer' do
      token = PayjpService.create_token(hash_for_payjp_token)
      expect(PayjpService.create_customer(token)).to eq customer_response
    end
  end

  describe '.charge!' do
    let(:user) { build(:user) }
    let(:product) { build(:product) }
    let!(:payment_method) { create(:payment_method, user: user) }

    it 'returns created charge' do
      charge = PayjpService.charge!(product, user)
      expect(charge).to eq charge_response
    end
  end
end
