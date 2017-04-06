Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create, :show]
      resources :locations, only: [:create, :show], key: :ethereum_address
      get "get_locations_for_good_path", to: "get_locations_for_good_path#index"
    end
  end
end
