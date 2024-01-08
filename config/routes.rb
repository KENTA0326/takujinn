Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :admin do
     #resources :sessions, only: [:new, :create, :destroy]
     resources :users, only: [:show, :edit, :update, :index, :destroy] do
       resource :relationships, only: [:create, :destroy]
        	get "followings" => "relationships#followings", as: "followings"
        	get "followers" => "relationships#followers", as: "followers"
     end
     resources :posts, only: [:index, :show]
     get "search" => "searches#search"
  end

  resources :posts, only: [:index, :show, :create, :new, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resources :post_comments, only: [:create, :destroy]
   resource :bookmarks, only: [:index, :create, :destroy]
  end

  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get "search" => "searches#search"

  resources :users, only: [:index, :show, :edit, :update] do
  patch '/users/withdraw' => 'users#withdraw'
  get '/users/unsbscribe', to: 'users#unsubscribe', as: 'users_unsubscribe'
  resource :relationships, only: [:create, :destroy]
        	get "followings" => "relationships#followings", as: "followings"
        	get "followers" => "relationships#followers", as: "followers"
  post "user/guest_sign_in", to: "sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
