require 'redis'

module Devise
  module Web3
    class RedisStore
      attr_reader :redis

      TTL = 10.minutes.to_i
      NONCE_KEY = "web3-auth-nonce"

      def initialize
        @redis = Redis.new(url: Devise::Web3::Config.redis_url)
      end

      def generate_nonce_with_id
        nonce_id = redis.incr(NONCE_KEY)
        nonce = SecureRandom.hex
        redis.setex(key(nonce_id), TTL, nonce)
        [nonce, nonce_id]
      end

      def fetch_nonce(nonce_id)
        redis.get(key(nonce_id))
      end

      private
      
      def key(id)
        "#{NONCE_KEY}-#{id}"
      end
    end
  end
end
