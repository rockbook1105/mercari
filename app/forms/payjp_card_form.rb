class PayjpCardForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :cvc, :string
  attribute :exp_month, :string
  attribute :exp_year, :string
  attribute :number, :string

  validates :cvc, length: { in: 3..4 }
  validates :exp_month, length: { is: 2 }
  validates :exp_year, length: { is: 4 }
  validates :number, format: { with: /\A\d{14,16}\z/ }
  validates :cvc,
            :exp_month,
            :exp_year,
            :number,
            presence: true

  validate :card_expiration

  def card_expiration
    expire_date = "#{exp_year}-#{exp_month}-01 00:00:00"
    errors.add(:card_is_expired, "カードの有効期限が切れています") if Time.zone.parse(expire_date) < Time.current
  end

  def save(user)
    return false if invalid?
    token = PayjpService.create_token(hash_for_payjp_token)
    customer = PayjpService.create_customer(token)
    PaymentMethod.create(payjp_customer_id: customer[:id], user_id: user.id)
  end

  def hash_for_payjp_token
    { card: attributes }
  end
end
