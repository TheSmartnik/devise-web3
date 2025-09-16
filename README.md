# Devise::Web3

`Devise-web3` allows to easily implement login with metamask or any other ethereum wallet providers. It works by providing a nonce for a user to sign and then cryptographically checking that signature is valid. This allows for a simple one click login popular among web3 apps.

## How it works
1. `Devise-web3` adds a new controller that generates a `nonce` for a wallet provider to sign(eg. metamask) along with `nonce_id`
2. `nonce` gets signed by a wallet provider
3. `signature`, `nonce_id` and wallet `address` is then sent by frontend to a regular sign_in endpoint provided by devise
4. `Devise-web3` then checks the signature and authenticates user

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
### Step 1
Add `:web3_authenticatable` module to your model along your other devise modules

Example
```
class User < ApplicationRecord
  devise :jwt_authenticatable,
    :web3_authenticatable
end

```
### Step 2
Generate migration
```shell
bin/rails g active_record:devise_web3 users
```
then run the migration

### Step 3
Generate config
```shell
bin/rails devise:web3:install
```
Provide your redis url in config
```ruby
config.web3 do |web3|
  web3.redis_url = nil
end
```

You're all set. It's time to setup a frontend

## Frontend Setup
### Vue
For vue you can use a [vue component](https://github.com/TheSmartnik/devise-web3-vue) or simply check the source code to see the general flow

### General Flow
1. Fetch user wallet address
```
const accounts = await window.ethereum.request({ method: "eth_requestAccounts" })
const address = accounts[0]
```
2. Fetch `nonce` and `nonce_id` through API
3. Sign the nonce
```
const web3 = new Web3()
const signature = await ethereum.request({
  method: "personal_sign",
  params: [web3.utils.fromUtf8(nonce), address],
})
```
4. Send `{ credenatils: { signature: signature, nonce_id: nonce_id, address: address }}` to sign in endpoint

## Issues & Improvements

There are many possibible improvements to `Devise-web3`. Feel free to create an issue with your requests

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
