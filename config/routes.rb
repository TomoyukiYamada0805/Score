Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  resources :relationships
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tops#hello"
  #resources :tops
  #resources :games
  resources :users
  resources :users do
    member do
      get :following
      get :followers
    end
  end
  resources :matches, :only => [:list, :show, :create, :update]
  get "/about" => "welcomes#index"
  get "/matches/:match_id/evaluate/:user_id" => "evaluates#index"
  get "/match_list/:year/:section" => "matches#list"
  get "/user/info/edit" => "users#edit"
  put "/user/info/edit" => "users#update"
  get "/user/info/update" => "users#update"
  get "/users/:id/likes" => "users#like"
  post "post_likes" => "likes#create"
  post "post_delete" => "likes#delete"
  
end
