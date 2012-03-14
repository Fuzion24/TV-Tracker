module TvShowsHelper
  def self.last_air_date(tv_show)
  	prev_episode = tv_show.tv_episodes.limit(1).where("airdate <= ?", '3/20/2012').first
  	if !prev_episode.nil?
  		return prev_episode.airdate
  	else
  		return "No previous episodes"
  	end
  end

  def self.next_air_date(tv_show)
  	next_episode = tv_show.tv_episodes.limit(1).where("airdate <= ?", '3/20/2012').first
  	if !next_episode.nil?
  		return next_episode.airdate
  	else
  		return "No scheduled episodes"
  	end
  end
end
