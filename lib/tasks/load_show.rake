namespace :tv_show do
	desc "Scrapes wikipedia for the given show and adds the data to the db"
	task :scrape  => :environment do |t, args|
		show_name = ENV['show']
		if show_name
			tv_show = WikiScraper.scrape_show(show_name)
			ConvertShow.persist_tv_show(tv_show)
		else
			puts "You must pass in show parameter with the show name"
		end
	end

	task :scrape_all  => :environment do |t, args|
		TvShow.destroy_all
		shows = File.new("#{Rails.root}/db/fixtures/SeedShows",'r')
		shows.each_line do |show_name|
			show_name.rstrip! 

			ImdbScraper.scrape_imdb(show_name)
			begin
				tv_show = EpguidesScraper.scrape_epguides(show_name)
				ConvertShow.persist_tv_show(tv_show)
			rescue
				puts "EpguidesScraper Failed to scan #{show_name}"
			end

			begin
				prepped_name = WikiScraper.prepare_show_name(show_name)
				tv_show = WikiScraper.scrape_show(prepped_name)
				ConvertShow.persist_tv_show(tv_show,false)
			rescue
				puts "WikiScraper Failed to scan #{show_name}"
			end

		end
	end
end