desc "Fetch Stock Levels"
task :fetch_stock => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
      
    FeedEntry.find_all_by_home('1-day').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_css(".stock_bar script").text[/\d+(?=',\s\/\/)/]    
          feed_entry.update_attribute(:stock, stock)  
    end
    FeedEntry.find_all_by_home('OffTheBack').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url)) 
              if doc.at_css(".sold_out")[:style].nil?
                stock = 0
              else
                stock = 100
              end    
          feed_entry.update_attribute(:stock, stock)  
    end
    FeedEntry.find_all_by_home('3Deals').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_xpath('//img[@width="40px"]')[:alt][/\d+/]+'0'    
          feed_entry.update_attribute(:stock, stock)  
    end
    FeedEntry.find_all_by_home('Daysale').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            unless doc.at_css(".stockdiv").nil? 
               stock = doc.at_css(".stockdiv img")[:src][/\d+/]
            else
               stock = 0
             end   
          feed_entry.update_attribute(:stock, stock)  
    end
    FeedEntry.find_all_by_home('Dealaday').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_css(".orange")[:style][/\d+/]    
          feed_entry.update_attribute(:stock, stock)  
    end
     
    FeedEntry.find_all_by_home('Snatchadeal').each do |feed_entry|  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_css("#product-info-right img")[:title][/\d+/]
          feed_entry.update_attribute(:stock, stock)  
    end
   
    
end


