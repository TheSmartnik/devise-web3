module ActionDispatch::Routing
  class Mapper
    def devise_web3_authenticatable(mapping, controllers) #:nodoc:
      resource :nonce, only: [:show],
        path: mapping.path_names[:nonce], controller: controllers[:nonces]
    end
  end
end
