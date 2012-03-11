class TvSeason < ActiveRecord::Base
	has_many :tv_episodes, :dependent => :destroy
	belongs_to :tv_show
end
