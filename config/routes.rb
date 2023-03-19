Rails.application.routes.draw do

  devise_for :users, skip:[:passwords],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip:[:passwords,:registrations],controllers:{
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  
  namespace :admin do
   root to: 'homes#top'
   resources :genres, except: [:show, :destroy, :new]
   resources :items, except: [:destroy]
   resources :users, except: [:new, :create, :destroy]
   resources :orders
  end  
  
  namespace :public do
   resources :users,except: [:new, :index]
   get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
   patch 'users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
   get 'orders/thanks', to: 'orders#thanks'
   post 'orders/confirm' => 'orders#confirm'
   resources :orders
   resources :addresses,except: [:new, :show]
   resources :items, only: [:index, :show]
   resources :cart_items, except: [:show, :new, :edit] 
   delete 'cart_items' => 'cart_items#destroy_all'
  end  
  
end
