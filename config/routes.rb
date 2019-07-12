Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  # Root
  root 'welcome#index', as: :home

  # Search
  get 'search', to: 'search#index', as: :search

  # Comments
  resources :comments

  # Follow, Membership, Session routes
  post 'follow/create', to: 'follow#create', as: :follow
  delete 'follow/destroy', to: 'follow#destroy', as: :unfollow

  post 'membership/create', to: 'memberships#create', as: :join
  delete 'membership/destroy', to: 'memberships#destroy', as: :quit

  resource :session, only: %i[new create destroy]
  get '/signin', to: 'sessions#new', as: :signin
  delete '/logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup

  # Groups
  get 'my_groups', to: 'users#my_groups', as: :my_groups
  get 'g', to: 'groups#index', as: :groups
  get 'g/new', to: 'groups#new', as: :new_group
  get 'g/:id', to: 'groups#show', as: :group
  get 'g/:id/edit', to: 'groups#edit', as: :edit_group
  get 'g/:id/members', to: 'groups#members', as: :members
  patch 'g/:id', to: 'groups#update'
  delete 'g/:id', to: 'groups#destroy'
  post 'g', to: 'groups#create'

  # Messages
  get 'g/:id/message', to: 'groups#message', as: :message
  patch 'g/:id/message', to: 'messages#update'
  get 'g/:id/m/:message_id', to: 'groups#message_view', as: :message_view
  delete 'g/:id/m/:message_id', to: 'messages#destroy', as: :delete_message
  get 'g/:id/m/:message_id/edit', to: 'groups#edit_message', as: :edit_message
  resources :messages, only: %i[create update delete]

  # Users
  get ':id', to: 'users#show', as: :profile
  get ':id/edit', to: 'users#edit', as: :edit_profile
  get ':id/followers', to: 'users#followers', as: :followers
  get '/users/new', to: redirect('/signup')
  resources :users, except: :index

end
