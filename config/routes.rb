Auth::Engine.routes.draw do
  post '/signup', to: 'registrations#create'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
