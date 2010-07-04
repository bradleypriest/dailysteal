desc "Fetch Off The Back Prices"
task :fetch_otb => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.offtheback.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#main_product, .side_deal").each do |item|  
    url = item.at_css("h1 a")[:href]
    published  = (Time.now+12.hours).hour>=9? Date.today+21.hours : Date.today-3.hours
    guid = url[/\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid 
    name = item.at_css("h1").text
    price = item.at_css(".price").text[/\$[\d,]+\.\d\d/]    
    picture = item.at_css("#main_image")[:src]
    if item.at_css(".sold_out")[:style].nil?
      stock = 0
    else
     stock = 100
    end
    unless item.at_css("strike").nil?
      fullprice = item.at_css("strike").text
    end
  


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




