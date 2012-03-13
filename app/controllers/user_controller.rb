class UserController < ApplicationController
  def shows
  	@user_shows = User.first.tv_shows
  	@user_episodes = User.first.tv_episodes
  end
end
