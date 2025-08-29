# frozen_string_literal: true
module Devise
  module Strategies
    class Web3Authenticatable < Authenticatable
      def authenticate!
        redis_store = Devise::Web3::RedisStore.new(nil)

        nonce = redis_store.fetch_nonce(nonce_id)
        return fail!("Nonce coldn't be found. Perhaps it's already expired") if nonce.blank?
        recovered_public_key = Eth::Signature.personal_recover nonce, signature
        recovered_address = Eth::Util.public_key_to_address(recovered_public_key)&.address

        return fail!("Signature verification failed") if recovered_address != address
        user = User.find_or_create_by(public_address: address)
        success!(user)
      end

      def valid?
        credentials = params[:credentials]
        credentials && credentials[:signature] && credentials[:nonce_id] && credentials[:address]
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
