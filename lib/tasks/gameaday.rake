desc "Fetch Gameaday Prices"
task :fetch_gameaday => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.gameaday.co.nz"
  doc = Nokogiri::HTML(open(url))  
      
      name = doc.at_css(".main_pn").text
      price = doc.at_css(".ablue-18-bold").text[/\$[\d,]+\.\d\d/]
      fullprice = doc.at_css(".black-14-bold:nth-child(5)").text[/\$[\d,]+\.\d\d/]
      picture = doc.at_css(".dealimage")[:src] 
 #     description = doc.at_css("#content").text

      
      
unless FeedEntry.exists? :name => name   
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => 'http://www.gameaday.co.nz/'+picture,
      :url        => 'http://www.gameaday.co.nz',
      :home       => 'Gameaday',
      :home_url   => 'http://www.gameaday.co.nz/',

      :published  => (Time.now+12.hours).hour>10? Date.today+22.hours : Date.today-2.hours,
      :rank       => 12,      
      :stock      => 100


      )
    end
  end
