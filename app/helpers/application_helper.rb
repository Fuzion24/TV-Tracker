module ApplicationHelper
  def title
    base_title = "Tv Tracker"
    if @title.nil?
      base_title
    else
      "#{@title} - Tv Tracker"
    end 
  end
end
