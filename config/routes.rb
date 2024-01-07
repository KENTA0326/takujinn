Rails.application.routes.draw do
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'search/search'
  end
  namespace :admin do
    get 'user/index'
    get 'user/show'
    get 'user/edit'
  end
  namespace :public do
    get 'search/search'
  end
  namespace :public do
    get 'bookmarks/index'
  end
  namespace :public do
    get 'user/show'
    get 'user/edit'
    get 'user/confirm'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/new'
    get 'posts/show'
  end
  namespace :public do
    get 'homes/top'
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
