class FeedEntry < ActiveRecord::Base
  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 240.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      
      
    if entry.url = "http://feed.1-day.co.nz/*"  
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title[/[^-]+/],
          :description  => entry.summary,
          :price        => entry.title[/\$[0-9\.]+/],
          :url          => entry.url,
          :guid         => entry.id
        )
        
      else entry.url = "http://www.offtheback.co.nz/"
        unless exists? :name => entry.title
         unless entry.published<(Time.now-1.day)
          create!(
          :name         => entry.title,
          :description  => entry.summary,
          :price        => entry.summary,
          :url          => entry.url,
          :guid         => entry.id,
          :published    => entry.published
          )
        
        end
        end
      end
    end
  end
end
end