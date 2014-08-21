Phy::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#main'

  get '/profile' => 'users#profile'

  get '/search_applicant' => 'advisers#search_applicant'
  post '/add_applicant' => 'advisers#add_applicant'
  delete '/adviser/applicants/:applicant_id' => 'advisers#remove_advisership', as: 'remove_advisership'
  get '/adviser/applicants/:applicant_id' => 'advisers#show_applicant', as: 'show_applicant'
 	post '/adviser/applicants/:applicant_id/update_status' => 'advisers#update_status', as: 'update_status'
 	post '/adviser/applicants/:applicant_id/task_status/:task_status_id/update_status' => 'advisers#update_task_status', as: 'update_task_status'
 	post '/adviser/applicants/:applicant_id/create_exam_answer' => 'advisers#create_exam_answer', as: 'create_exam_answer'	
 	delete '/adviser/applicants/:applicant_id/exam_answers/:exam_answer_id' => 'advisers#delete_exam_answer', as: 'delete_exam_answer'
 	post '/adviser/applicants/:applicant_id/update_message' => 'advisers#update_message', as: 'update_message'

 	get '/applicant/exams/:exam_answer_id' => 'applicants#show_exam', as: 'show_exam'
 	post '/applicant/:exam_answer_id' => 'applicants#submit_answer', as: 'submit_answer'
 	get '/adviser/applicants/:applicant_id/exams/:exam_answer_id' => 'advisers#detail_about_exam', as: 'detail_exam'
end
