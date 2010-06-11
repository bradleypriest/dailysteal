desc "Fetch TheDeal Prices"
task :fetch_thedeal => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.thedeal.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#ctl00_ctl00_MainContent_uxHome_DealOfTheDay_pnlProductList .quickproductinfo").each do |item|
      
      url = item.at_css(".producttitle")[:href]
      published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
      guid = url[/\d+(?=&)/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid  
      name = item.at_css(".producttitle").text
      price = item.at_css(".buynow").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".sbp").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css(".productpic img")[:src] 
    
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => 'http:'+picture,
      :url        => 'http://www.thedeal.co.nz/'+url,
      :guid       => guid,
      :published  => published,
      :home       => 'TheDeal',
      :home_url   => 'http://www.thedeal.co.nz/DailyDeals.aspx',
      :stock      =>  100,
      :rank       =>  8
      )
    end
  end
end