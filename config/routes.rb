TvTracker::Application.routes.draw do
  root :to => 'home#index'
  match "/my_shows" => "users#shows"
  match "/top_shows" => "tv_shows#top_shows"
  match "/all_shows" => "tv_shows#all_shows"
  resources :tv_episodes
  resources :tv_shows
  #authlogic
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'register' => 'users#new', :as =>:register
  resources :user_sessions
  #end authlogic
  resources :users #temp
end
