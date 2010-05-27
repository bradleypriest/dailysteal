class Feeds2Controller < ApplicationController

  def index
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end


  def show
    @feed = Feed.find(params[:id])
  end
  
  def yesterday
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  def daybefore
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  def small
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  def faq
  end
  
  def help
  end

  def about
  end
  
end