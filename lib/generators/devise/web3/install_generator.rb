module Devise
  module Web3
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'Add DeviseInvitable config variables to the Devise initializer and copy DeviseInvitable locale files to your application.'
      INSTALL_CONTENT = <<-CONTENT
  # ==> Configuration for :web3_authenticatable
  # config.web3 do |web3|
  #   web3.redis_url = nil
  # end

      CONTENT

      def add_config_options_to_initializer
        devise_initializer_path = 'config/initializers/devise.rb'

        if File.exist?(devise_initializer_path)
          old_content = File.read(devise_initializer_path)

          if old_content.match(Regexp.new(/^\s # config.web3 do/))
            say_status(:identical, "Configuration for :web3_authenticatable already exists", :blue)
          else
            inject_into_file(devise_initializer_path, before: "  # ==> Configuration for :confirmable\n") do
              INSTALL_CONTENT
            end
          end
        end
      end
    end
  end
end
