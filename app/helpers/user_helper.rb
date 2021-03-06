module UserHelper
  def self.episodestoday(shows, date)
      shows.collect { |tv_show|
      tv_show.tv_episodes.where("airdate = '#{date}'").all
   }.flatten.sort_by {|show| show.tv_season.tv_show.air_time.nil? ? 0 : show.tv_season.tv_show.air_time}
  end

  def self.day_of_week(offset)
  	target_date = (Date.today + offset)
  	target_date.strftime("%A")
  end

  def self.numeric_date(offset)
	target_date = (Date.today + offset)
  	target_date.strftime("%D")
  end 
end
