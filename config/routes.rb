Rails.application.routes.draw do
  
  post '/sms' => "forms#sms", :as => :sms
  
  resources :answers
  
  resources :forms do
    resources :questions
    resources :submissions
  end
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
