class UserController < ApplicationController
  def shows
  	@user_shows = TvShow.all
  	@user_episodes = User.first.tv_episodes
        @tv_shows = TvShow.all
  end
end
