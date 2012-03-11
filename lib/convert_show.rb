
class ConvertShow
	def self.persist_tv_show(tv_show)
		show = ::TvShow.new
		show.name = tv_show[:name]
		show.tv_seasons = convert_seasons(tv_show[:seasons])
		show.save
	end
	def self.convert_seasons(seasons)
		seasons.collect do |season|
			::TvSeason.new(
				:number => season[:season_num],
				:tv_episodes => convert_episodes(season[:episodes])
			)
		end
	end

	def self.convert_episodes(episodes)
		episodes.collect do |episode|
			::TvEpisode.new(
				:name => episode[:episode_name],
				:number => episode[:episode_number],
				:seriesnum => episode[:series_num],
				:description => episode[:description],
				:airdate => 	episode[:air_date]
			)
		end
	end
end   

# class TVHelper
# 	def self.show(show_name)
# 		{
# 			:name 			=> show_name,
# 			:seasons		=> []
# 		}
# 	end

# 	def self.season(season_num, season_premiere, season_finale)
# 		{
# 			:season_num 		=> season_num,
# 			:season_premiere    => season_premiere,
# 			:season_finale		=> season_finale,
# 			:episodes 			=> []
# 		}
# 	end

# 	def self.episode(series_num, episode_num, episode_name, air_date, description)
# 		{
# 			:series_num			=> series_num,
# 			:episode_number 	=> episode_num,
# 			:name 				=> episode_name,
# 			:air_date			=> air_date,
# 			:description        => description
# 		}
# 	end
# end
