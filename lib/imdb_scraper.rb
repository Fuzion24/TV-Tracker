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

	def self.top_shows
		imdb = ImdbParty::Imdb.new
		imdb.popular_shows.each_with_index do |show, i|
			imdb_show = imdb.find_movie_by_id(show[:imdb_id])
			tv_show = TvShow.find_or_new(imdb_show.title)
			ConvertShow.convert_and_save_logo(imdb_show.poster_url, tv_show, true)
			tv_show.description = imdb_show.plot
			tv_show.premiered = imdb_show.release_date
			tv_show.save

			top_show = TopShow.find_or_new(tv_show,i)
			top_show.save
		end
	end
end