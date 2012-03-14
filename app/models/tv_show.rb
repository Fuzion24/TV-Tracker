class TvShow < ActiveRecord::Base
has_attached_file :icon, PAPERCLIP_CONFIG[:show][:icon]
        
        has_many :tv_show_episodes
        has_many :tv_episodes,    :through => :tv_show_episodes
	has_many :tv_seasons, :dependent => :destroy
	has_one :tv_image, :dependent => :destroy
end
