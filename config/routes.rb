Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'contacts#index'

  resources :contacts, except: :show

  get '/contact/:id', to: 'contacts#edit'
end
