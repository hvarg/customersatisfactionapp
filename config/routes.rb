Rails.application.routes.draw do
  root 'surveys#new'

  resources :surveys, only: [:index, :new, :create, :update, :edit] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
