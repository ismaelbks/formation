Rails.application.routes.draw do
  
  #devise routes (authentification)
  devise_for :users

  get '/signup', to: "registrations#new"
  
  get 'pages/home'

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
