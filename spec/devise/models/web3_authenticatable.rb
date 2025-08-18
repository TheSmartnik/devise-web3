require 'spec_helper'

RSpec.describe Devise::Models::Web3Authenticatable do
  include_context 'fixtures'

  describe '#find_for_web3_authentication(address)' do
    it 'finds record which has given `sub` as `id`' do
      expect(User.find_for_web3_authentication(public_address)).to eq(user)
    end

    it 'returns nil when user is not found' do
      expect(User.find_for_web3_authentication('none')).to be_nil
    end
  end
end
