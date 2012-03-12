class TvEpisodesController < ApplicationController
  def index
    @tv_episodes = TvEpisode.all
  end

  def show
    @tv_episode = TvEpisode.find(params[:id])
    @tv_season = TvSeason.find(@tv_episode.tv_season_id)
    @tv_show = TvShow.find(@tv_season.tv_show_id)
    @title = @tv_episode.name + '-Tv Tracker'
  end
  
  def today
    @tv_episodes = TvEpisode.where("airdate > ? AND airdate < ?", Date.today.prev_week, Date.today.prev_week + 1.week)
  end

end
