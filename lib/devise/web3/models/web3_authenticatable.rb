# frozen_string_literal: true

require 'active_support/concern'

module Devise
  module Models
    module Web3Authenticatable
      extend ActiveSupport::Concern

      included do
        def self.find_for_jwt_authentication(address)
          find_by(public_address => address)
        end
      end
    end
  end
end
