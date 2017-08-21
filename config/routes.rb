Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise routes (authentification)
  devise_for :users
  get 'users/:id' => 'users#show', as: 'user_dashboard'
  
  get 'pages/home'




  root to: "pages#home"

  resources :projects, only: [:index, :new, :create, :show, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
