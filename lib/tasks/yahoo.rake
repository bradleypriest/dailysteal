desc "Fetch Yahoo Prices"
task :fetch_yahoo => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://shopping.yahooxtra.co.nz/DailyDeals.aspx"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#dailyDealItems li").each do |item|  
      name = item.at_css(".deal-title").text
      price = item.at_css(".deal-price a strong").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css(".deal-image")[:style][/\/\/.+JPG/i]
      fullprice = item.at_css(".deal-price a em").text[/\$[\d,]+\.\d\d/]
      url = item.at_css(".deal-item a")[:href][/\/.+/]



     unless FeedEntry.exists? :name => name
       FeedEntry.create!(
       :name       => name,
       :price      => price,
       :fullprice  => fullprice,
       :url        => 'http://shopping.yahooxtra.co.nz'+url,
       :picture    => 'http:'+picture,
       :published  => (Time.now).hour>10? Date.today+10.hours : Date.today-14.hours,
       :home       => 'YahooXtra',
       :home_url   => 'http://shopping.yahooxtra.co.nz/DailyDeals.aspx/',
       :rank       => 17,
       :stock     => 100

           )

       end
     end
     end