class FeedEntry < ActiveRecord::Base
  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
 def self.update_from_feed_continuously(feed_url, delay_interval = 1.minutes)
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
      
  unless exists? :name => entry.title     
    if entry.id.include? "http://www.1-day.co.nz/"
        create!(
          :name         => entry.title[/[^-]+/],
          :description  => entry.summary,
          :price        => entry.title[/\$[0-9\.]+/],
          :url          => entry.url,
          :published    => entry.published,
          :picture      => 'http://www.1-day.co.nz/images/products/'+entry.id[/\w+\z/]+'_large.jpg',
          :guid         => entry.id,
          :home         => 'http://www.1-day.co.nz'
        )
      elsif entry.summary.include? "http://www.6shooter.co.nz/"
              create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/.+\.jpg/],
              :price        => entry.summary[/NOW\s(\$\d+\.\d\d)/],
              :guid         => entry.id,
              :home         => 'http://www.6shooter.co.nz'
              )
                
      elsif entry.id == "http://www.offtheback.co.nz/"
         unless entry.published<(Time.now-1.day)
          create!(
          :name         => entry.title,
          :description  => entry.summary,
          :price        => entry.summary[/\$[0-9\.]+/],
          :url          => entry.summary[/\/\/images\S+[a-z]/],
          :published    => entry.published,
          :picture      => 'http:'+entry.summary[/\/\/images\S+[a-z]/],
          :guid         => entry.id,
          :home         => 'http://www.offtheback.co.nz'
          
          )
  
        end
      end
    end
  end
end
end