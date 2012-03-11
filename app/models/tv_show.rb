class TvShow < ActiveRecord::Base
	has_many :tv_seasons, :dependent => :destroy
end
