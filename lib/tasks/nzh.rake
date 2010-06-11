desc "Fetch NZH Prices"
task :fetch_nzh => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://shopping.nzherald.co.nz/DailyDeals.aspx"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css(".daily-deal-details li").each do |item|
    url = item.at_css(".product-name a")[:href]
    published  = (Time.now).hour>=10? Date.today+10.hours : Date.today-14.hours
    guid = url[/\d\d\d\d\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid    
      name = item.at_css(".product-name a").text
      price = item.at_css(".deal-pricing a span").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css(".deal-image a img")[:src]
      fullprice = item.at_css(".product-rrp").text[/\$[\d,]+\.\d\d/]

       FeedEntry.create!(
       :name       => name,
       :price      => price,
       :fullprice  => fullprice,
       :url        => 'http://shopping.nzherald.co.nz'+url,
       :picture    => 'http:'+picture,
       :published  => published,
       :home       => 'NZHerald',
       :home_url  => 'http://shopping.nzherald.co.nz/DailyDeals.aspx/',
       :guid      => guid,
       :rank      => 16,
       :stock     => 100

           )

       end
     end
     end