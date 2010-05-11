class FeedEntry < ActiveRecord::Base  
  
  require 'rubygems'
  require 'feedzirra'
  
  def self.update_from_feed(feed_url)  
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    
    feed.entries.each do |entry|
      unless exists? :guid=>entry.id
        create!(
              :title        => entry.title[/[^-]+/]  
              :description  => entry.summary,  
              :price        => entry.title[/\$[0-9\.]+/],  
              :site         => entry.id,  
              :guid         => entry.id
              )
            end   
         end
      end  
    end
      
          