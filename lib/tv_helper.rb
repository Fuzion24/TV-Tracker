class TVHelper
	def self.show(show_name)
		{
			:name 			=> show_name,
			:seasons		=> []
		}
	end

	def self.season(season_num, season_premiere, season_finale)
		{
			:season_num 		=> season_num,
			:season_premiere    => season_premiere,
			:season_finale		=> season_finale,
			:episodes 			=> []
		}
	end

	def self.episode(series_num, episode_num, season_number, episode_name, air_date, description)
		{
			:series_num			=> series_num,
			:season_num			=> season_number,
			:episode_number 	=> episode_num,
			:episode_name 		=> episode_name,
			:air_date			=> air_date,
			:description        => description
		}
	end
end