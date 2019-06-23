Rails.application.routes.draw do
  get '/users/new', to: redirect('/signup')
  resources :users, except: :index
  get 'signup', to: 'users#new', as: :signup
end
