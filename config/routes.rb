Rails.application.routes.draw do
  devise_for :users
  #get 'admin_pannel/home'
  root 'admin_pannel#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
