Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get '/signin', to: 'sessions#new', as: :signin
  delete '/logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup
  get ':id', to: 'users#show', as: :profile
  get ':id/edit', to: 'users#edit', as: :edit_profile
  get '/users/new', to: redirect('/signup')
  resources :users, except: :index

end
