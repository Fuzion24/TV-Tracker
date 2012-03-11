class TvSeason < ActiveRecord::Base
	has_many :tv_episodes, :dependent => :destroy
end
