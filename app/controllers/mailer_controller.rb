class MailerController < ApplicationController
  def index
    @feeds = FeedEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_entries }
    end
  end

end
