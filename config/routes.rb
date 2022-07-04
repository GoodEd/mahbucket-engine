Mahbucket::Engine.routes.draw do
  root to: 'items#index'

  resources :items

  resources :tags, as: :acts_as_taggable_on_tag

  get '/search', to: 'search#search'

  # OmniAuth
  get '/auth/:provider/callback', to: 'sessions#create'
end
