desc "Fetch Off The Back Prices"
task :fetch_otb => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.offtheback.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#daily_deals .product_item").each do |item|  
    name = item.at_css("h1").text
    price = item.at_css(".price").text[/\$[\d,]+\.\d\d/]
    url = item.at_css("h1 a")[:href]
    picture = item.at_css("#main_image")[:src]
unless item.at_css("strike").nil?
    fullprice = item.at_css("strike").text
end
  

unless FeedEntry.exists? :url => url 
  FeedEntry.create!(
  :name       => name,
  :price      => price,
  :fullprice  => fullprice,
  :url        => url,
  :picture    => picture,
  :published  => (Time.now+12.hours).hour>9? Date.today+21.hours : Date.today-3.hours,
  :home       => 'OffTheBack',
  :home_url   => 'http://www.offtheback.co.nz/',
  :guid       =>  url[/\d+/],
  :rank       =>  2
      )
    end
  end
end




