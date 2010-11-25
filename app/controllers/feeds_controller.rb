class FeedsController < ApplicationController

  def index
    set_meta_tags :title => "NZ's Best 1-Day and Daily Deals",
                  :keywords => "Daily Deals, 1-day deals, deals, one day, 1-day, Daily Steal", 
                  :description => "The Daily Steal is New Zealand's home of best daily deals and 1 day sales. We put together a fresh collection of the NZ's best deals every day."
    order = params[:order].present? ? ['published DESC','rank'] : 'rank'               
    @feeds = FeedEntry.where('published > ?', (Time.now-1.day)).order(order)
    
    # find(
    # :all,
    # :conditions => ['published > ?', (Time.now-1.day)],
    # :order => 'rank'
    # )

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
    set_meta_tags :title => "Previous Deals Page #{params[:page]}",
                  :description => 'Previous Daily Deals',
                  :keywords => 'NZ deals, daily deals, 1-day'
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
  

end