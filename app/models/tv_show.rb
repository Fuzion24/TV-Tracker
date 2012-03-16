class TvShow < ActiveRecord::Base
	has_attached_file :icon, PAPERCLIP_CONFIG[:show][:icon]
    has_many :tv_show_episodes
    has_many :tv_episodes,    :through => :tv_show_episodes
	has_many :tv_seasons, :dependent => :destroy


	def self.find_or_new(show_name)
		show = self.where(:name => show_name).first
		show ||= self.new(:name => show_name)
		return show
	end
end
