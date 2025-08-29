require 'spec_helper'

require 'fixtures/rails_app/config/environment'

RSpec.describe "DeviceSessions", type: :request do
  include Devise::Test::IntegrationHelpers
  include_context 'fixtures'

  context 'with invalid params' do
    it 'should return error' do
      post "/users/sign_in", params: { credentials: { signature: "sdfs", nonce_id: "123", address: "sdfs" }}

      expect(response.status).to eq(401)
    end
  end

  context 'with valid params' do
    let(:redis_store_response) { Devise::Web3::RedisStore.new(nil).generate_nonce_with_id }
    let(:nonce) { redis_store_response.first }
    let(:nonce_id) { redis_store_response.last }
    let(:key) { Eth::Key.new }
    let(:params) do
      {
        credentials: {
          signature: key.personal_sign(nonce),
          address: key.address.to_s.downcase,
          nonce_id: nonce_id
        }
      }
    end

    before do
      User.create(public_address: key.address.to_s.downcase)
    end

    it 'should authenticate user' do
      result = post "/users/sign_in", params: params

      expect(response.status).to eq(201)
    end
  end
end
