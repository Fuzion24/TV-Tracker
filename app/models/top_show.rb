class TopShow < ActiveRecord::Base
	belongs_to :tv_show

	def self.find_or_new(tv_show, top_pos)
		show = self.where(:tv_show_id => tv_show.id).first
		show ||= self.new(:tv_show_id => tv_show.id, :position => top_pos)
		show
	end
end
