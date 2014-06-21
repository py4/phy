Phy::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#main'
end
