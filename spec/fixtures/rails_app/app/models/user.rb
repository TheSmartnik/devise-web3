class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :web3_authenticatable
end
