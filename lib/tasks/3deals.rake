desc "Fetch 3Deals Prices"
task :fetch_3deals => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.3deals.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#hp-product-detail-middle , td:nth-child(3) .navigation-product, #home-list td:nth-child(2) .navigation-product").each do |item|  
    href = item.at_css("a")[:href].gsub(/deal/,'http://www.3deals.co.nz/site/deal')
     doc = Nokogiri::HTML(open(href))  

     doc.css("#product-detail-middle").each do |item|  
       name = item.at_css("#allImages p:nth-child(1)").text.capitalize
       name2 = item.at_css("h1").text
       price = item.at_css("#product-detail-price").text[/\$[\d,]+\.\d\d/]
       picture = item.at_css("#mainImage")[:src]
       fullprice = item.at_css("#do-not-pay").text[/\$[\d,]+\.\d\d/]
       stock = item.at_xpath('//img[@width="40px"]')[:alt][/\d+/]+'0'
       
       
unless FeedEntry.exists? :url => href
  FeedEntry.create!(
  :name       => name+' '+name2,
  :price      => price,
  :fullprice  => fullprice,
  :url        => href,
  :picture    => 'http://www.3deals.co.nz/site/'+picture,
  :published  => (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours,
  :home       => '3Deals',
  :home_url   => 'http://www.3Deals.co.nz/',
  :guid       =>  href[/deal-\w+/],
  :rank       =>  4,
  :stock      => stock

      )
    end   
  end
end
end




