# Devise::Web3

`Devise-web3` allows to easily implement login with metamask or any other ethereum wallet providers. It works by providing a nonce for a user to sign and then cryptographically checking that signature is valid. This allows for a simple one click login popular among web3 apps.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise-web3'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install devise-web3

## Usage
Add `:web3_authenticatable` module to your model along your other devise modules

Example
```
class User < ApplicationRecord
  devise :jwt_authenticatable,
    :web3_authenticatable
end

```

Generate migration
```shell
bin/rails g active_record:devise_web3 users
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/devise-web3.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
