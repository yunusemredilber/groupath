Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: :signup
  get ':id', to: 'users#show', as: :profile
  get ':id/edit', to: 'users#edit', as: :edit_profile
  get '/users/new', to: redirect('/signup')
  resources :users, except: :index

end
