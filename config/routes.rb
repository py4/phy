Phy::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#main'

  get '/profile' => 'users#profile'

  get '/search_applicant' => 'advisers#search_applicant'
  post '/add_applicant' => 'advisers#add_applicant'
  delete '/profile/applicants/:applicant_id' => 'advisers#remove_advisership', as: 'remove_advisership'
  get '/profile/applicants/:applicant_id' => 'advisers#show_applicant', as: 'show_applicant'
 	post '/profile/applicants/:applicant_id/update_status' => 'advisers#update_status', as: 'update_status'
 	post '/profile/applicants/:applicant_id/task_status/:task_status_id/update_status' => 'advisers#update_task_status', as: 'update_task_status'
end
