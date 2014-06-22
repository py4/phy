Phy::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#main'

  get '/profile' => 'users#profile'

  get '/search_customer' => 'users#search_customer'
  post '/add_customer' => 'users#add_customer'
  delete '/profile/customers/:customer_id' => 'users#remove_advisership', as: 'remove_advisership'
  get '/profile/customers/:id' => 'users#show_customer', as: 'show_customer'
end
