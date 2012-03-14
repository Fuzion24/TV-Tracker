module UserHelper
  def self.episodestoday(shows, date)
      shows.collect { |tv_show|
      tv_show.tv_episodes.where("airdate = '#{date}'").all
   }.flatten
  end
  def self.showdate(offset)
        (Date.today + offset).strftime('%A') + ' ' + (Date.today + offset).strftime('%F')  
  end 
end
