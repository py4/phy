Phy::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#main'

  get '/profile' => 'users#profile'
end
