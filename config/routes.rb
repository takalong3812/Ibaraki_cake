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
  end  
  
  namespace :public do
   resources :users,except: [:new, :index]
   get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
   patch 'users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  end  
  
end
