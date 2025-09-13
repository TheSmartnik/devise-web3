require 'spec_helper'

require 'fixtures/rails_app/config/environment'

RSpec.describe "Web3Authenticatable", type: :request do
  include Devise::Test::IntegrationHelpers
  include_context 'fixtures'

  context 'with invalid params' do
    it 'should return error' do
      post "/users/sign_in", params: { credentials: { signature: "sdfs", nonce_id: "123", address: "sdfs" }}

      expect(response.status).to eq(401)
    end
  end

  context 'with valid params' do
    let(:redis_store_response) { Devise::Web3::RedisStore.new.generate_nonce_with_id }
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

    describe "sign_in" do
      context "when user doesn't exist" do
        it 'should creates user' do
          result = post "/users/sign_in", params: params

          expect(response.status).to eq(201)
          expect(User.last.public_address).to eq(key.address.to_s.downcase)
        end
      end

      context 'when user exist' do
        before do
          User.create(public_address: key.address.to_s.downcase)
        end

        it 'authenticates user' do
          result = post "/users/sign_in", params: params

          expect(response.status).to eq(201)
          expect(User.count).to eq(1)
          expect(User.last.public_address).to eq(key.address.to_s.downcase)
        end
      end
    end

    describe "web3_nonce" do
      it 'should generate nonce' do
        result = get "/users/nonce"

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json['nonce']).to be_present
        expect(json['nonce_id']).to be_present
      end
    end
  end
end
