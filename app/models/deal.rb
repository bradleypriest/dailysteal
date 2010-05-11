class Deal < ActiveRecord::Base
  
  
  deal = Feedzirra::Feed.fetch_and_parse("http://feed.1-day.co.nz/1-day")
  deal.entries.each do |entry|
 #       unless exists? :guid=>entry.id
          self.entries.create(
                :title        => entry.title[/[^-]+/]  
                :description  => entry.summary,  
                :price        => entry.title[/\$[0-9\.]+/],  
                :site         => entry.id,  
                :guid         => entry.id
                )
              end   
           end
        end
