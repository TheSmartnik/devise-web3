require_relative 'lib/devise/web3/version'

Gem::Specification.new do |spec|
  spec.name          = "devise-web3"
  spec.version       = Devise::Web3::VERSION
  spec.authors       = ["TheSmartnik"]
  spec.email         = ["misharinn@gmail.com"]

  spec.summary       = %q{Devise extension that allows to easily login with ethereum wallet}
  spec.description   = <<~EOF
    Devise-web3 allows to easily implement login with metamask or any other ethereum wallet providers.
    It works by providing a nonce for a user to sign and then cryptographically checking that signature is valid.
    This allows for a simple one click login popular among web3 apps.
  EOF
  spec.homepage      = "https://thesmartnik.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'devise', '~> 4.0'
  spec.add_dependency 'eth', '~> 0.5.15'
  spec.add_dependency 'redis'

  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'sqlite3'

  spec.add_development_dependency 'pry'
end
