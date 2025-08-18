# frozen_string_literal: true
module Devise
  module Strategies
    class Web3Authenticatable < Authenticatable
      def authenticate!
        redis_store = RedisStore.new(nil)

        nonce = redis_store.fetch_nonce(nonce_id)
        recovered_public_key = Eth::Signature.personal_recover nonce, signature
        recovered_address = Eth::Util.public_key_to_address(recovered_public_key)&.address

        fail!("Signature verification failed") if recovered_address != address
        user = User.find_or_create_by(public_address: address)
        success!(user)
      end

      def valid?
        params[:credentials] && params[:credentials][:signature]
      end

      def nonce_id
        params[:credentials][:nonce_id]
      end

      def address
        params[:credentials][:address]
      end

      def signature
        params[:credentials][:signature]
      end

    end
  end
end

Warden::Strategies.add(:web3_authenticatable, Devise::Strategies::Web3Authenticatable)
