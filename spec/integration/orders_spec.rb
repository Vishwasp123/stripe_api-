require 'swagger_helper'

RSpec.describe 'Orders API', type: :request do
  path '/orders' do
    post 'Creates an order' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: { '$ref' => '#/components/schemas/OrderInput' }
      response '201', 'order created' do
        schema '$ref' => '#/components/schemas/Order'
        run_test!
      end
      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'
        run_test!
      end
    end
  end
end
