Rails.application.routes.draw do

  resources :messages
  get '/', to: 'sessions#new', as: :home # Temp Controller

  get 'g', to: 'groups#index', as: :groups
  get 'g/new', to: 'groups#new', as: :new_group

  post 'follow/create', to: 'follow#create', as: :follow
  delete 'follow/destroy', to: 'follow#destroy', as: :unfollow

  post 'membership/create', to: 'memberships#create', as: :join
  delete 'membership/destroy', to: 'memberships#destroy', as: :quit

  resource :session, only: [:new, :create, :destroy]
  get '/signin', to: 'sessions#new', as: :signin
  delete '/logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup

  get ':id', to: 'users#show', as: :profile
  get ':id/edit', to: 'users#edit', as: :edit_profile
  get ':id/followers', to: 'users#followers', as: :followers

  get 'g/:id', to: 'groups#show', as: :group
  get 'g/:id/edit', to: 'groups#edit', as: :edit_group
  get 'g/:id/members', to: 'groups#members', as: :members
  patch 'g/:id', to: 'groups#update'
  delete 'g/:id', to: 'groups#destroy'

  post 'g', to: 'groups#create'

  get '/users/new', to: redirect('/signup')
  resources :users, except: :index

end
