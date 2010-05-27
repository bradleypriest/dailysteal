desc "Fetch catchoftheday Prices"
task :fetch_catchoftheday => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.catchoftheday.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#rightcol").each do |item|  
      name = item.at_css("#catch_name").text
      name2 = item.at_css("h2").text 
      price = item.at_css("#price").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css("#main_image")[:src]
    if item.at_css(".cssnav a img")[:alt].include? "Almost"
          stock = 25
    elsif item.at_css(".cssnav a img")[:alt].include? "Sold"
          stock = 0
    else
          stock = 100
    end
unless FeedEntry.exists? :guid => name    
    FeedEntry.create!(
      :name       => name+' '+name2,
      :price      => price,
      :picture    => 'http://www.catchoftheday.co.nz/'+picture,
      :published  => (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours,
      :url        => 'http://www.catchoftheday.co.nz',
      :guid       => name,
      :home       => 'Catchoftheday',
      :home_url   => 'http://www.catchoftheday.co.nz',
      :rank       => 7,
      :stock      => stock

      )
    end
  end
end