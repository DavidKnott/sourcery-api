Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :goods, only: [:create, :show]
      resources :locations, only: [:create, :show], key: :ethereum_address
    end
  end
end
