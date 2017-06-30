Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		devise_scope :user do
  			post 'signup' => 'registrations#create'
  			post 'signin' => 'sessions#create'
  			post 'sign_up_with_fb' => 'registraions#sign_up_with_fb'
  			delete 'signout' => 'sessions#destroy'
  		end

      get 'export' => 'exports#index'
  	end
    #get 'api/current_user'
  end

  # get 'api/current_user'

  devise_for :users
  #get 'admin_pannel/home'
  root 'admin_pannel#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
