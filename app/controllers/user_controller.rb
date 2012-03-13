class UserController < ApplicationController
  def shows
  	@user_shows = TvShow.all
  	@user_episodes = User.first.tv_episodes

  	# tv_show = @user_shows[3]
  	# send_data(
   #      tv_show.tv_image.file_data, 
   #      :type => tv_show.tv_image.content_type,
   #      :filename => tv_show.tv_image.file_name,
   #      :disposition => 'inline'
   #    )
  end
end
