class UserEpisode < ActiveRecord::Base
	belongs_to :user
  	belongs_to :tv_episode
end