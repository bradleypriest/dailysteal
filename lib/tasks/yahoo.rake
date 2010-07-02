desc "Fetch Yahoo Prices"
task :fetch_yahoo => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://shopping.yahooxtra.co.nz/DailyDeals.aspx"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#dailyDealItems li").each do |item|  
    
    url = item.at_css(".deal-item a")[:href][/\/.+/]
    published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
    guid = url[/\d\d\d\d\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid

      name = item.at_css(".deal-title").text
      price = item.at_css(".deal-price a strong").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".deal-price a em").text[/\$[\d,]+\.\d\d/]
      
      
      href = 'http://shopping.yahooxtra.co.nz'+url
      doc = Nokogiri::HTML(open(href))
      picture = doc.at_css(".mainImageContainer a")[:href]
      
         
     
       FeedEntry.create!(
       :name       => name,
       :price      => price,
       :fullprice  => fullprice,
       :url        => href,
       :picture    => 'http:'+picture,
       :published  => published,
       :home       => 'YahooXtra',
       :home_url   => 'http://shopping.yahooxtra.co.nz/DailyDeals.aspx/',
       :guid      => guid,
       :rank       => 17,
       :stock      => 100

           )

       end
     end
     end