class Payment < ApplicationRecord
  attr_accessor :number, :exp_month, :exp_year, :cvc
  belongs_to :order
  after_create :create_on_stripe
  def create_on_stripe
    token = get_token
    params = { amount: order.amount_cents, currency: 'usd', source: token}
    response = Stripe::Charge.create(params)
    self.stripe_id = response.id
  end
  def get_token
    token = Stripe::Token.create({
      card: {
        number: number,
        exp_month:  exp_month,
        exp_year: exp_year,
        cvc: cvc
       }
    })
    token.id
  end
end