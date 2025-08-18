# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Devise do
  it 'adds web3_authenticatable module' do
    expect(described_class::ALL).to include(:web3_authenticatable)
  end

  it 'associates web3_authenticatable module with jwt strategy' do
    expect(described_class::STRATEGIES[:web3_authenticatable]).to eq(:web3_authenticatable)
  end
end
