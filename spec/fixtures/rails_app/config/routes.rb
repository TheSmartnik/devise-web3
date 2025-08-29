Rails.application.routes.draw do

  devise_for :users,
    # controllers: { sessions: :registrations },
    defaults: { format: :json }
end
