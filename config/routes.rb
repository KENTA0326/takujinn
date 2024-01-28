Rails.application.routes.draw do
  namespace :admin do
    get 'reports/index'
    get 'reports/show'
  end
  namespace :public do
    get 'reports/new'
  end
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :reports, only: [:index, :show, :update]
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
      collection do
        get 'search'
      end
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      resource :bookmarks, only: [:index, :create, :destroy]
    end

    resources :notifications, only: [:index] do
      patch :checked, on: :member
      delete :destroy_all, on: :collection
      get "search" => "notifications#search"
    end

    resources :contacts, only: [:new, :create] do
      collection do
        post 'confirm'
        post 'back'
        get 'done'
      end
    end

    get "search" => "searches#search"
    get "mypage" => "users#mypage", as: 'users_mypage'

    devise_scope :user do
      resources :messages, only: [:create]
      resources :rooms, only: [:create, :show]
      resources :users, only: [:index, :show, :edit, :update] do
        member do
          get :favorites
        end
        post "profile/:user_id/report" => "reports#create", as: "profile_report"
        get "profile/:user_id/report/new" => "reports#new", as: "profile_reports_new"
        patch '/users/withdraw' => 'users#withdraw'
        get '/users/unsbscribe', to: 'users#unsubscribe', as: 'users_unsubscribe'
        resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
      end
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
  end
end
