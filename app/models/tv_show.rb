class TvShow < ActiveRecord::Base
	has_many :tv_seasons, :dependent => :destroy
	has_one :tv_image, :dependent => :destroy
end
