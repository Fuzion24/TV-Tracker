TvTracker::Application.routes.draw do
  root :to => 'home#index'
  match "/my_shows" => "user#shows"
  match "/top_shows" => "tv_shows#top_shows"
  match "/all_shows" => "tv_shows#all_shows"
  resources :tv_episodes
  resources :tv_shows
end
