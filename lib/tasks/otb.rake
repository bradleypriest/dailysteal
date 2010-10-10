desc "Fetch Off The Back Prices"
task :fetch_otb => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.offtheback.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css(".tabset li").each do |item|  
    url = item.at_css("a")[:href]
    published  = (Time.now+12.hours).hour>=9? Date.today+21.hours : Date.today-3.hours
    guid = url[/\d+/]+(published.strftime(fmt='%d%m%g')) rescue url+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid 
    name = item.at_css("strong.heading").text
    price = item.at_css(".sale .price").text.chomp    
    picture = item.at_css(".tab-b img")[:src]
    stock = 100
    fullprice = item.at_css(".normal .price").text.chomp
  


  FeedEntry.create!(
  :name       => name,
  :price      => price,
  :fullprice  => fullprice,
  :url        => url,
  :picture    => picture,
  :published  => published,
  :home       => 'OffTheBack',
  :home_url   => 'http://www.offtheback.co.nz/',
  :guid       =>  guid,
  :rank       =>  2,
  :stock      => stock
      )
    end
  end
end




