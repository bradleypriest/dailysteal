desc "Fetch Stock Levels"
task :fetch_stock => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  
  

	  
    FeedEntry.find_all_by_home('1-day', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|
      if feed_entry.published>=Time.now-1.day  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_css(".stock_bar script").text[/\d+(?=',\s\/\/)/]    
          feed_entry.update_attribute(:stock, stock)  
      end
    end
    FeedEntry.find_all_by_home('OffTheBack', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|
      if feed_entry.published>=Time.now-1.day  
          doc = Nokogiri::HTML(open(feed_entry.url)) 
              if doc.at_css(".sold_out")[:style].nil?
                stock = 0
              else
                stock = 100
              end    
          feed_entry.update_attribute(:stock, stock)  
      end
    end
    FeedEntry.find_all_by_home('3Deals', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|  
          if feed_entry.published>=Time.now-1.day
            doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_xpath('//div[@style="margin-bottom: 5px; font-weight: bold;"]/img')[:alt][/\d+/]+'0'    
          feed_entry.update_attribute(:stock, stock)  
    
          end
    end
    FeedEntry.find_all_by_home('Daysale', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|  
          if feed_entry.published>=Time.now-1.day
            doc = Nokogiri::HTML(open(feed_entry.url))  
            unless doc.at_css(".stockdiv").nil? 
               stock = doc.at_css(".stockdiv img")[:src][/\d+/]
            else
               stock = 0
            end   
          feed_entry.update_attribute(:stock, stock)  
          end
    end
    FeedEntry.find_all_by_home('Dealaday', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|  
          if feed_entry.published>=Time.now-1.day
            doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = 100-(doc.at_css(".orange, .green, .red")[:style][/\d+/].to_i)    
              feed_entry.update_attribute(:stock, stock)  
          end
    end
     
    FeedEntry.find_all_by_home('Snatchadeal', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry| 
      if feed_entry.published>=Time.now-1.day 
          doc = Nokogiri::HTML(open(feed_entry.url))  
            stock = doc.at_css("#product-info-right img")[:title][/\d+/]
          feed_entry.update_attribute(:stock, stock)  
      end
    end
   
    FeedEntry.find_all_by_home('6Shooter', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry| 
      if feed_entry.published>=Time.now-1.day 
          doc = Nokogiri::HTML(open(feed_entry.url)) 
        if doc.at_css(".ss_info_full h3").text.include? "SOLD"
          stock = 0
        else 
          stock = 100
        end
          feed_entry.update_attribute(:stock, stock)  
      end
    end
    
    FeedEntry.find_all_by_home('Catchoftheday', :conditions => ['published > ?', (Time.now-1.day)]).each do |feed_entry|
      if feed_entry.published>=Time.now-1.day  
          doc = Nokogiri::HTML(open(feed_entry.url))  
            if doc.at_css(".cssnav a img")[:alt].include? "Almost"
                  stock = 25
            elsif doc.at_css(".cssnav a img")[:alt].include? "Sold"
                  stock = 0
            else
                  stock = 100
            end
          feed_entry.update_attribute(:stock, stock)  
      end
    end
    
      
      
    doc = Nokogiri::HTML(open('http://www.mightyape.co.nz/daily-deals'))
    
      doc.css(".deal").each do |item|
          name = item.at_css(".title .title").text
          stock = item.at_xpath('div[@class="dealBox"]/div')[:class][/\d+/]
            FeedEntry.find_all_by_name(name).each do |feed_entry|
               if feed_entry.published>=Time.now-1.day 
              feed_entry.update_attribute(:stock, stock)
            end
        end
      end
      
  #    doc = Nokogiri::HTML(open('http://www.ziwi.co.nz/one_day_deals.php'))  
        
  #        doc.css(".box_").each do |item|
   #         href = item.at_css("a")[:href]
    #        stock =item.at_css("p img")[:src][/\d+/]+'0'
     #         FeedEntry.find_all_by_guid(href).each do |feed_entry|
      #          if feed_entry.published>=Time.now-1.day
       #         feed_entry.update_attribute(:stock, stock)
#              end
 #         end
  #      end
        
        
        
     
end



