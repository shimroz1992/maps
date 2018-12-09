Rails.application.routes.draw do

  resources :locations do
    member do
      get :get_share_location
      post :post_share_location
    end
    collection do
      get :loginin_users
      get :shared_locations
      get  :shared_with_location
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  get '/:username' => 'home#public_share'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
