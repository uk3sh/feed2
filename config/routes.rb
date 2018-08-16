Rails.application.routes.draw do
  
  root 'forms#index'
  
  post '/sms' => "forms#sms", :as => :sms

  root 'pages#show'

  resources :answers
  resources :forms do
    collection {post :import}
    resources :questions
    resources :submissions
  end
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
