require 'rubygems'
require 'open-uri' 
require 'nokogiri'
require 'yaml'

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

	def self.episode(series_num, episode_num, episode_name, air_date, description)
		{
			:series_num			=> series_num,
			:episode_number 	=> episode_num,
			:episode_name 		=> episode_name,
			:air_date			=> air_date,
			:description        => description
		}
	end
end

class WikiScraper
	def self.scrape_show(show_name)
		tv_show = TVHelper.show(show_name)
		url = "http://en.wikipedia.org/wiki/List_of_#{show_name}_episodes"
		puts url
		doc = Nokogiri::HTML(open(URI.escape(url)))
		doc.css('div#content div#bodyContent div[lang=en] table[class=wikitable]').each_with_index do |tv_season_html, i|
			next if i == 0 #this is the table with a list of all the seasons
			#puts "\n\nSeason #{i}"

			table_headings = {}
			tv_season_html.css("tr th").each_with_index do |heading, index|
				case heading.text
					when /U.S. viewers/ 			then key = "USViewersMillions"
					when "\342\204\226" 			then key = "SeriesNum"
						when /No. in\sseries/ 		then key = "SeriesNum"
					when /air date/ 				then key = "AirDate"
						when /Original Airdate/		then key = "AirDate"
					when /Written/  				then key = "Writer"
					when /Title/ 					then key = "EpisodeName"
					when /#/ 						then key = "EpisodeNum"
						when /No. in\sseason/		then key = "EpisodeNum"
					else key = heading.text
				end
				table_headings[key] = index
			end

			#For now skip tables were we are missing necessary keys.. 
			#We could probably be a bit smarter about this by checking the Header tags on the page for regex matches on 
			#"Season" etc
			skip_table = false
			["SeriesNum", "EpisodeNum", "EpisodeName", "AirDate"].each do |key|
				if table_headings[key].nil?
					skip_table = true 
					puts "Skipping table with keys: #{table_headings.inspect} because #{key} is nil"
					break
				end
			end
			if skip_table
				#puts tv_season_html
				next 
			end


			tv_season = TVHelper.season(i,nil,nil)

			tv_season_html.css("tr").each_with_index do |episode, index|
				next if episode["class"] !=  "vevent"
				episode_items 	= episode.css("td")
				series_num 		= 	episode_items[table_headings["SeriesNum"]].text
				episode_num 	= 	episode_items[table_headings["EpisodeNum"]].text
				episode_name 	= 	episode_items[table_headings["EpisodeName"]].text
				air_date 		= 	episode_items[table_headings["AirDate"]].text
				if !tv_season_html.css("tr")[index+1].nil? && tv_season_html.css("tr")[index+1]["class"].nil?
					description = 	tv_season_html.css("tr")[index+1].text
				else
					description = ""
				end
				tv_season[:episodes] << TVHelper.episode(series_num, episode_num, episode_name, air_date, description)
				#puts "\n#{series_num} #{episode_num} #{episode_name} #{air_date} \n\t Description: #{description}"
			end
				tv_show[:seasons] << tv_season if tv_season[:episodes].count > 0
		end
		tv_show
	end
end




