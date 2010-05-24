desc "Fetch TheDeal Prices"
task :fetch_thedeal => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.thedeal.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#ctl00_ctl00_MainContent_uxHome_DealOfTheDay_pnlProductList .quickproductinfo").each do |item|  
      name = item.at_css(".producttitle").text
      price = item.at_css(".buynow").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".sbp").text[/\$[\d,]+\.\d\d/]
      url = item.at_css(".producttitle")[:href]
      picture = item.at_css(".productpic img")[:src] 
unless FeedEntry.exists? :name => name    
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => 'http:'+picture,
      :url        => 'http://www.thedeal.co.nz/'+url,
      :guid       => url[/\d+(?=&)/],
      :published  => (Time.now.hour)>12? Date.today+12.hours : Date.today-12.hours,
      :home       => 'TheDeal',
      :home_url   => 'http://www.thedeal.co.nz/DailyDeals.aspx',
      :rank       =>  8
      )
    end
  end
end