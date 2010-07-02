class FeedsController < ApplicationController

  def index
    @feeds = FeedEntry.find(
    :all,
    :conditions => ['published > ?', (Time.now-1.day)],
    :order => 'rank'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  def show
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end


  
  def yesterday
    @feeds = FeedEntry.paginate(
     :page => params[:page],
     :conditions => ['published < ?', (Time.now-1.day)],
     :order => 'published DESC',
     :per_page => '40'
     )
     

     
    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  
  def small
    stylesheets << 'scaffoldsmall'
    @feeds = FeedEntry.find(
    :all,
    :conditions => ['published > ?', (Time.now-1.day)],
    :order => 'rank'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  
  end
  
  def mailer
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  def edit
    redirect_to root_url
  end
  
  def new
    redirect_to root_url
  end
  
  
end