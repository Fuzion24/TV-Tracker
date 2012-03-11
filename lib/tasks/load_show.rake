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
end