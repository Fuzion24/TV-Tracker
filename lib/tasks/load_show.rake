namespace :tv_show do
	desc "Scrapes wikipedia for the given show and adds the data to the db"
	task :scrape  => :environment do |t, args|
		show_name = ENV['show']
		if show_name
			show_name.gsub!(" ", "_")
			tv_show = WikiScraper.scrape_show(show_name)
			ConvertShow.persist_tv_show(tv_show)
		else
			puts "You must pass in show parameter with the show name"
		end
	end

	task :scrape_all  => :environment do |t, args|
		TvShow.destroy_all
		[   \
			"Justified", "Mad_Men", "Family_Guy", "Breaking_Bad", "Lost", "True_Blood", \
			"Arrested_Development", "Californication", "The_Big_Bang_Theory","Archer","The_Office_(U.S._TV_series)", \
			"How_I_Met_Your_Mother", "Prison_Break", "Dexter", "Tosh.0" \
		].each do |show_name|
			begin
				tv_show = WikiScraper.scrape_show(show_name)
				ConvertShow.persist_tv_show(tv_show)
			rescue
				puts "Failed to scan #{show_name}"
			end
		end
	end
end