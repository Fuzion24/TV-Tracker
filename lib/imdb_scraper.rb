require 'rubygems'
require 'imdb_party'

class ImdbScraper
	def self.scrape_imdb(show_name)
		imdb = ImdbParty::Imdb.new
		search_res = imdb.find_by_title(show_name)[0] #Hope its the first one?

		imdb_tv_show = imdb.find_movie_by_id(search_res[:imdb_id])

		tv_show = TvShow.find_or_new(show_name)
		ConvertShow.convert_and_save_logo(imdb_tv_show.poster_url, tv_show, true)
		tv_show.description = imdb_tv_show.plot
		tv_show.premiered = imdb_tv_show.release_date
		tv_show.save
		#puts "found show:  #{tv_show.inspect}"
		# imdb.popular_shows.each do |show|
		# 	puts show.inspect
		# end
	end
end