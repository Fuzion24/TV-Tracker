class TvShowEpisode < ActiveRecord::Base
  belongs_to :tv_show
  belongs_to :tv_episode
end
