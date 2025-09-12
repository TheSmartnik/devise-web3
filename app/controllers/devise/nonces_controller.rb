class Devise::NoncesController < DeviseController
  prepend_before_action :require_no_authentication, only: [:show]

  def show
    nonce, nonce_id = redis_store.generate_nonce_with_id
    render json: { nonce: nonce, nonce_id: nonce_id }
  end

  private

  def redis_store
    @redis_store ||= Devise::Web3::RedisStore.new(nil)
  end
end
