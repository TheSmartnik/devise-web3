require "bundler/setup"
require "devise/web3"
require 'rails'

require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
# require 'action_view/railtie'

require 'rspec/rails'
require 'pry'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path(
  'fixtures/rails_app/config/environment', __dir__
)

SPEC_ROOT = Pathname(__FILE__).dirname
Dir[SPEC_ROOT.join('support/**/*.rb')].sort.each do |file|
  require file
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.before(:each, type: :request) do
    Rails.application.try(:reload_routes_unless_loaded)
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
