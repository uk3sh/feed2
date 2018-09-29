Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: "registrations" }
  
  
  
  root 'dashboard#index'

  post '/sms' => "forms#sms", :as => :sms
  post '/email' => "forms#email", :as => :email
  get '/thanks' => "submissions#thanks", :as => :thanks  
  get '/qrcode' => "forms#generate_qr" , :as => :qrcode
  

  resource :dashboard, controller: 'dashboard', :only => ['index']
  resources :answers
  resources :forms do
    collection {post :import}
    collection {post :bulk_email}
    resources :questions
    resources :submissions
  end
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
