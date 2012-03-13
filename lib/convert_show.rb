
class ConvertShow
	def self.persist_tv_show(tv_show)
		show = ::TvShow.new
		show.name = tv_show[:name]
		convert_and_save_logo(tv_show[:logo_path], show) if tv_show[:logo_path]
		show.tv_seasons = convert_seasons(tv_show[:seasons])
		show.save
	end
	def self.convert_seasons(seasons)
		seasons.collect do |season|
			::TvSeason.new(
				:number => season[:season_num],
				:tv_episodes => convert_episodes(season[:episodes])
			)
		end
	end

	def self.get_file_name(path)
		last_slash = path.rindex("\/")
		if last_slash.nil?
			last_slash = 0 
		else
			last_slash += 1
		end
		return path[last_slash..path.length-1]
	end

	def self.convert_and_save_logo(path, show)
		path = path[2..path.length]
      	url = URI.parse("http://#{path}")
      	ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.78 Safari/535.11'
  		req = Net::HTTP::Get.new(url.path, { 'User-Agent' => ua })
  		res =  Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  		file_sha1 = Digest::SHA1.hexdigest(res.body)
  		f_name = "#{Rails.root}/tmp/#{file_sha1}"
  		f = File.new(f_name, "w")
  		f.write(res.body)
  		f.close
  		show.icon = File.new(f_name, "r")
  		show.icon_file_name= file_sha1 
	end

	def self.convert_episodes(episodes)
		episodes.collect do |episode|
			::TvEpisode.new(
				:name => episode[:episode_name],
				:number => episode[:episode_number],
				:seriesnum => episode[:series_num],
				:description => episode[:description],
				:airdate => 	episode[:air_date]
			)
		end
	end
end   
