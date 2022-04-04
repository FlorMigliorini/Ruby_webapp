Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get 'home/index'
  get 'home/video'
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  resources :courses do
    resources :reviews
  end


  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
