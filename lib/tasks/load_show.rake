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
		["Justified", "Mad_Men", "Family_Guy", "Breaking_Bad", "How_I_Met_Your_Mother", "Prison_Break", "Dexter"].each do |show_name|
			begin
				tv_show = WikiScraper.scrape_show(show_name)
				ConvertShow.persist_tv_show(tv_show)
			rescue
				puts "Failed to scan #{show_name}"
			end
		end
	end
end