class PayjpService
  require "payjp"

  def self.create_token(hash_for_payjp_token)
    Payjp.api_key = ENV["api_key"]
    Payjp::Token.create(hash_for_payjp_token, 'X-Payjp-Direct-Token-Generate': 'true')
  end

  def self.create_customer(token)
    Payjp::Customer.create(card: token)
  end

  def self.charge!(product, user)
    Payjp::Charge.create(
      amount: product.price,
      customer: user.payment_method.payjp_customer_id,
      currency: 'jpy'
    )
  end
end
