Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise routes (authentification)
  devise_for :users
  get 'users/:id' => 'users#show', as: 'user_dashboard'
  
  get 'pages/home'

  root to: "pages#home"

  resources :projects, only: [:index, :new, :create, :show, :edit, :update]

  get 'categories/:id/projects', to: 'categories#list', as: 'categories-projects'

  #get 'projects/:id/contreparties', to: 'contreparties#list', as: 'contreparties-projects'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
