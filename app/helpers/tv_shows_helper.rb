module TvShowsHelper
  def self.last_air_date(tv_show)
  	tv_show.tv_episodes.limit(1).where("airdate <= ?", '3/20/2012').first
  	return "03/12/2012"
  end

  def self.next_air_date(tv_show)
  	return "03/19/2012"
  end
end
