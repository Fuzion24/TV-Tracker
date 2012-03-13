class User < ActiveRecord::Base
	has_many :user_episodes
	has_many :tv_episodes, 		:through => :user_episodes
	has_many :tv_shows, 		:through => :user_shows
end
