Rails.application.routes.draw do
  
  #devise routes (authentification)
  devise_for :users
  get 'users/:id' => 'users#show', as: 'user_dashboard'
  
  get 'pages/home'


  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
