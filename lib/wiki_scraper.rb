require 'rubygems'
require 'open-uri' 
require 'nokogiri'
require 'yaml'
require File.join(File.dirname(__FILE__), "tv_helper")


class WikiScraper

	def self.clean_episode_name(episode_name)
		last_quote = episode_name.rindex("\"")  
		episode_name[1..last_quote-1]
	end

	def self.clean_show_name(show_name)
		show_name.gsub("_", " ")
	end

	def self.standarize_table_keys(headings)
			table_headings = {}
			headings.each_with_index do |heading, index|
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
			return table_headings
	end

	def self.table_does_not_necessary_keys?(table_keys)
			#For now skip tables were we are missing necessary keys.. 
			#We could probably be a bit smarter about this by checking the Header tags on the page for regex matches on 
			#"Season" etc
			skip_table = false
			["SeriesNum", "EpisodeNum", "EpisodeName", "AirDate"].each do |key|
				if table_keys[key].nil?
					skip_table = true 
					puts "Skipping table with keys: #{table_keys.inspect} because #{key} is nil" if DEBUG
					break
				end
			end
			return skip_table
	end

	def self.series_information(series_table, garbage)
		table_keys = {}
		series_table.css("tr th").each_with_index do |heading, index|

		end
	end

	def self.find_logo(imgs)
		imgs.each do |img|	
			return img['src'] if img['src'] =~ /logo/
		end
		return nil
	end

	def self.scrape_show(show_name)
		tv_show = TVHelper.show(clean_show_name(show_name))
		url = "http://en.wikipedia.org/wiki/List_of_#{show_name}_episodes"
		puts "Scraping #{url}" if DEBUG
		doc = Nokogiri::HTML(open(URI.escape(url)))
		tv_show[:logo_path] = find_logo(doc.css("img"))
		tv_series_tables = doc.css('div#content div#bodyContent div[lang=en] table[class=wikitable]')
		series_information(tv_series_tables[0], tv_show)
		tv_series_tables.each_with_index do |tv_season_html, i|
			#puts "\n\nSeason #{i}"

			table_legend = standarize_table_keys(tv_season_html.css("tr th"))
			next if table_does_not_necessary_keys?(table_legend)

			tv_season = TVHelper.season(i,nil,nil)

			tv_season_html.css("tr").each_with_index do |episode, index|
				next if episode["class"] !=  "vevent"

				episode_items 	= episode.css("td")
				series_num 		= 	episode_items[table_legend["SeriesNum"]].text
				episode_num 	= 	episode_items[table_legend["EpisodeNum"]].text
				episode_name 	= 	episode_items[table_legend["EpisodeName"]].text
				air_date 		= 	episode_items[table_legend["AirDate"]].text

				episode_name = clean_episode_name(episode_name)

				#check that there is another line in the table and that it does not have a class (all episode lines have class = vevent)
				if !tv_season_html.css("tr")[index+1].nil? && tv_season_html.css("tr")[index+1]["class"].nil?
					description = tv_season_html.css("tr")[index+1].text
				else
					description = ""
				end

				tv_season[:episodes] << TVHelper.episode(series_num, episode_num,i, episode_name, air_date, description)
				#puts "\n#{series_num} #{episode_num} #{episode_name} #{air_date} \n\t Description: #{description}"
			end
				tv_show[:seasons] << tv_season if tv_season[:episodes].count > 0
		end
		tv_show
	end
end




