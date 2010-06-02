class FeedsController < ApplicationController

  def index
    @feeds = FeedEntry.find(
    :all,
    :conditions => ['published > ?', (Time.now-1.day)]
    )

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
     :per_page => 50
     )
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
  
  def mailer
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # yesterday.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end
  
  def faq
  end
  
  
end