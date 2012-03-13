class UserController < ApplicationController
  def shows
  	@user_shows = User.first.tv_shows
  end
end
