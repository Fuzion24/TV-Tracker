TvTracker::Application.routes.draw do
  root :to => 'home#index'
  match "/my_shows" => "user#shows"
  resources :tv_episodes
  resources :tv_shows
end
