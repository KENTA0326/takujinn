Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
     resources :users, only: [:show, :edit, :update, :index, :destroy] do
       resource :relationships, only: [:create, :destroy]
        	get "followings" => "relationships#followings", as: "followings"
        	get "followers" => "relationships#followers", as: "followers"
     end
     resources :posts, only: [:index, :show]
     get "search" => "searches#search"
  end

  scope module: :public do
    root to: "homes#top"
    resources :posts, only: [:index, :show, :create, :new, :destroy] do
     resource :favorites, only: [:create, :destroy]
     resources :post_comments, only: [:create, :destroy]
     resource :bookmarks, only: [:index, :create, :destroy]
    end 
    
    resources :contacts, only: [:new, :create] do
      collection do
          post 'confirm'
          post 'back'
          get 'done'
      end
    end

    get "search" => "searches#search"
    devise_scope :user do
     resources :users, only: [:index, :show, :edit, :update] do
      patch '/users/withdraw' => 'users#withdraw'
      get '/users/unsbscribe', to: 'users#unsubscribe', as: 'users_unsubscribe'
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"

     end 
     post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
