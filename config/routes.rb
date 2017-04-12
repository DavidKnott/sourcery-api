Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create, :show, :index]
      resources :checkpoints, only: [:create, :show], key: :ethereum_address
      get "get_checkpoints_for_good_path", to: "get_checkpoints_for_good_path#index"
      resources :lots, only: [:create]
    end
  end
end
