class User < ActiveRecord::Base
        acts_as_authentic do |c|
          c.login_field = :handle
        end

	has_many :user_episodes
	has_many :user_shows
	has_many :tv_episodes, 		:through => :user_episodes
	has_many :tv_shows, 		:through => :user_shows
end
