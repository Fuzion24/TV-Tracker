require 'rubygems'
require 'open-uri' 
require 'nokogiri'
require 'yaml'
require 'CSV'
require File.join(File.dirname(__FILE__), "tv_helper")


	def find_csv(links)
		links.each do |link|	
			return link['href'] if link['href'] =~ /exportToCSV/
		end
	end

	def scrape_epguides(show_name)
		tv_show =TVHelper.show(show_name)
		url = "http://www.epguides.com/#{show_name}/"
		doc = Nokogiri::HTML(open(URI.escape(url)))
		csv_uri = find_csv(doc.css("a"))
		csv_doc = Nokogiri::HTML(open(URI.escape(csv_uri)))
		csv_data = csv_doc.css("pre")[0].text
		csv_data.lstrip! #remove empty first line
		tv_seasons = {}
		CSV.parse(csv_data) do |row|
			next if row[0] == "number"
			series_num = row[0].to_i
			season = row[1].to_i
			episode_num = row[2].to_i
			production_code = row[3]
			airdate = row[4]
			episode_name = row[5]
			special = row[6]

			tv_seasons[season] = TVHelper.season(season,nil,nil)if tv_seasons[season].nil?
			tv_seasons[season][:episodes] << TVHelper.episode(series_num, episode_num,season, episode_name, airdate, "")
		end
		tv_show[:seasons] = tv_seasons.values
	end

puts scrape_epguides("FamilyGuy").inspect