require 'rubygems'
require 'open-uri' 
require 'nokogiri'
require 'yaml'

class WikiTVScraper

	def scrape_show(show_name)

		url = "http://en.wikipedia.org/wiki/List_of_#{show_name}_episodes"
		puts url
		doc = Nokogiri::HTML(open(URI.escape(url)))
		doc.css('div#content div#bodyContent div[lang=en] table[class=wikitable]').each_with_index do |tv_season, i|
			next if i == 0 #this is the table with a list of all the seasons
			puts "\n\nSeason #{i}"

			table_headings = {}
			tv_season.css("tr th").each_with_index do |heading, index|
				case heading.text
					when /U.S. viewers/ 			then key = "USViewersMillions"
					when "\342\204\226" 			then key = "SeriesNum"
						when /No. in\sseries/ 		then key = "SeriesNum"
					when /air date/ 				then key = "AirDate"
					when /Written/  				then key = "Writer"
					when /Title/ 					then key = "EpisodeName"
					when /#/ 						then key = "EpisodeNum"
						when /No. in\sseason/		then key = "EpisodeNum"
					else key = heading.text
				end
				table_headings[key] = index
			end
			
			tv_season.css("tr").each_with_index do |episode, index|
				next if episode["class"] !=  "vevent"
				episode_items 	= episode.css("td")

				series_num 		= 	episode_items[table_headings["SeriesNum"]].text
				episode_num 	= 	episode_items[table_headings["EpisodeNum"]].text
				episode_name 	= 	episode_items[table_headings["EpisodeName"]].text
				air_date 		= 	episode_items[table_headings["AirDate"]].text
				if !tv_season.css("tr")[index+1].nil? && tv_season.css("tr")[index+1]["class"].nil?
					description = 	tv_season.css("tr")[index+1].text
				else
					description = ""
				end
				puts "\n#{series_num} #{episode_num} #{episode_name} #{air_date} \n\t Description: #{description}"
			end
		end

	end
end

scraper = WikiTVScraper.new

#["Breaking_Bad", "Family_Guy", "Justified", "Mad_Men", "entourage"].each do |show_name|
#	begin
#	scraper.scrape_show(show_name)
#	rescue
#		puts "#{show_name} fucked up"
#	end
#end

scraper.scrape_show("Entourage")



