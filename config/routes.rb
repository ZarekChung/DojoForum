Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts do
    resources :replies
    member do
    post :collect
    post :uncollect
    end
  end
  resources :categories
  resources :friends, only: [:create, :destroy]

  resources :users, only: [:show, :edit, :update] do
    member do
      get :posts
      get :drafts
      get :replies
      get :collects
      get :friend_list
      post :accept
      post :ignore
    end
  end
end
