class TvEpisode < ActiveRecord::Base
	belongs_to :tv_season


	def self.find_or_new(name, number, season_number, seriesnum, description, airdate)
		show = self.where(:name => season_number, :number => number).first
		
		parsed_date = (airdate == "UNAIRED") || (airdate == "TBA") ? nil : Date.parse(airdate, true).strftime("%Y-%m-%d")

		if !show.nil?
			if show.airdate != Date.parse(airdate, true).strftime("%Y-%m-%d")
				puts "Episode #{name} #{season_number}-#{number} of #{show.tv_season.tv_show.name} had original airdate of #{show.airdate} and is getting #{airdate}"
			end
			#The early bird gets the worm for the description
			show.description = description if show.description.nil? && !description.nil?
		end

		show ||= self.new(
				:name => 			name,
				:number => 			number,
				:season_number => 	season_number,
				:seriesnum => 		seriesnum,
				:description => 	description,
				:airdate => 		parsed_date
			)
		return show
	end
end