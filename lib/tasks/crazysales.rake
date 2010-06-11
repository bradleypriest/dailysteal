desc "Fetch crazysales Prices"
task :fetch_crazysales => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.crazysales.co.nz/daily_deals/"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css(".deal-now .rc6").each do |item|
      image = item.at_css("img")[:src]
      published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
      guid = image[/\d+/]+(published.strftime(fmt='%d%m%g'))

unless FeedEntry.exists? :guid => guid
    
      name = item.at_css(".n").text
      price = item.at_css(".p").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".s").text[/\$[\d,]+\.\d\d/]
      url = item.at_css("a")[:href]
      href = 'http://www.crazysales.co.nz'+url
    doc = Nokogiri::HTML(open(href))  
      stock = doc.at_css("#prdt_infos .l")[:width][/\d+/]
          
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => href,
      :picture    => 'http://www.crazysales.co.nz'+image,
      :published  => published,
      :home       => 'Crazysales',
      :home_url   => 'http://www.crazysales.co.nz/daily_deals/',
      :guid       =>  guid,
      :rank       =>  13,
      :stock      => stock

      )
end
end
end

