Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :portfolios, except: []
  resources :posts, except: []
  resources :users
  resources :home, only: [] do 
    collection do 
      post :contact_form
    end
  end  

  get 'about', to: "home#about"
  root to: "home#index"
end
