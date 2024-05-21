# spec/swagger_helper.rb

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.3',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          OrderInput: {
            type: :object,
            properties: {
              amount_cents: { type: :integer },
              payment_method: { type: :string },
              customer_id: { type: :integer }
            },
            required: ['amount_cents', 'payment_method', 'customer_id']
          },
          PaymentInput: {
            type: :object,
            properties: {
              order_id: { type: :integer },
              number: { type: :string },
              exp_month: { type: :integer },
              exp_year: { type: :integer },
              cvc: { type: :string }
            },
            required: ['order_id', 'number', 'exp_month', 'exp_year', 'cvc']
          },
          Order: {
            type: :object,
            properties: {
              id: { type: :integer },
              amount_cents: { type: :integer },
              payment_method: { type: :string },
              customer_id: { type: :integer }
            }
          },
          Payment: {
            type: :object,
            properties: {
              id: { type: :integer },
              order_id: { type: :integer },
              stripe_id: { type: :string }
            }
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
