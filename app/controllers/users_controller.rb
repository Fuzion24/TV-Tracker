class UsersController < ApplicationController
  def shows
    @user_episodes = current_user.tv_episodes
    @tv_shows = current_user.tv_shows
  end
  
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  def add_show
    current_user.tv_shows << TvShow.find(params[:id])
    redirect_to :controller => "tv_shows", :action => "all_shows"
  end

   def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:root, :notice => 'Registration successfull.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
