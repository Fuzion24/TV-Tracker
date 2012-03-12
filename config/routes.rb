TvTracker::Application.routes.draw do
  root :to => 'home#index'

  resources :tv_episodes
  resources :tv_shows
end
