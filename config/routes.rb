Rails.application.routes.draw do
  
  get 'expenses/statistics'

  devise_for :users
  resources :expenses
  resources :plans
  resources :calculators 

  authenticated :user do
	   root "expenses#index", as: "authenticated_root"
  end

  root "welcome_page#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
