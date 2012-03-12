class HomeController < ApplicationController
  def index
  	@tv_shows = TvShow.all
  	@tv_show = TvShow.first
  end

end
