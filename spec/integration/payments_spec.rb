require 'swagger_helper'

RSpec.describe 'Payments API', type: :request do
  path '/payments' do
    get 'Retrieves all payments' do
      tags 'Payments'
      produces 'application/json'
      response '200', 'payments found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Payment' }
        run_test!
      end
    end

    post 'Creates a payment' do
      tags 'Payments'
      consumes 'application/json'
      parameter name: :payment, in: :body, schema: { '$ref' => '#/components/schemas/PaymentInput' }
      response '201', 'payment created' do
        schema '$ref' => '#/components/schemas/Payment'
        run_test!
      end
      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'
        run_test!
      end
    end
  end

  path '/payments/{id}' do
    get 'Retrieves a payment' do
      tags 'Payments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'payment found' do
        schema '$ref' => '#/components/schemas/Payment'
        run_test!
      end
      response '404', 'payment not found' do
        run_test!
      end
    end

    patch 'Updates a payment' do
      tags 'Payments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :payment, in: :body, schema: { '$ref' => '#/components/schemas/PaymentInput' }
      response '200', 'payment updated' do
        schema '$ref' => '#/components/schemas/Payment'
        run_test!
      end
      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'
        run_test!
      end
    end

    delete 'Deletes a payment' do
      tags 'Payments'
      parameter name: :id, in: :path, type: :string
      response '204', 'payment deleted' do
        run_test!
      end
      response '404', 'payment not found' do
        run_test!
      end
    end
  end
end
