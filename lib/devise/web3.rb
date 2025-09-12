require 'devise'
require 'redis'
require 'eth'
require 'devise/web3/version'
require 'devise/web3/redis_store'
require 'devise/web3/engine'
require 'devise/web3/models/web3_authenticatable'
require 'devise/web3/strategies/web3_authenticatable'
require 'devise/web3/routes'

module Devise

  module Web3
    class Error < StandardError; end

    Devise.add_module :web3_authenticatable,
      strategy: true,
      model: 'devise/web3/models/web3_authenticatable',
      controller: :nonces,
      route: true,
      no_input: true
  end
end
