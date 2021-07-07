Rails.application.routes.draw do
  resources :book_instances do
    member do
      get 'lending'
    end
  end
  resources :users
  resources :authors
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
