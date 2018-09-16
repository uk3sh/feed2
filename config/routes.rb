Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: "registrations" }
  
  
  get '/' => 'dashboard#index', :constraints => { :subdomain => /.+/ }
  root 'dashboard#index'

  post '/sms' => "forms#sms", :as => :sms
  get '/thanks' => "submissions#thanks", :as => :thanks  
  get '/qrcode' => "forms#generate_qr" , :as => :qrcode
  

  resource :dashboard, controller: 'dashboard', :only => ['index']
  resources :answers
  resources :forms do
    collection {post :import}
    resources :questions
    resources :submissions
  end
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
