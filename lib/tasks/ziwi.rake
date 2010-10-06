desc "Fetch Ziwi Prices"
task :fetch_ziwi => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.ziwi.co.nz/one_day_deals.php"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css(".box_").each do |item|  
    href = item.at_css("a")[:href]
    published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
    guid = href[/\d\d+/]+(published.strftime(fmt='%d%m%g'))
    unless FeedEntry.exists? :guid => guid
    stock =item.at_css("p img")[:src][/\d+/]+'0'
     doc = Nokogiri::HTML(open(href))  
       doc.css("#content form .box").each do |item|  
         name = item.at_css(".pageHeading b").text
         author = item.at_css(".title .bold").text.gsub(/\s+/,' ').gsub(',','&')
         price = item.at_css(".bold.black").text[/\$[\d,]+\.\d\d/]
         picture = item.at_css("#image img")[:src]
         fullprice = item.at_css(".strike").text[/\$[\d,]+\.\d\d/]
        
    FeedEntry.create!(
    :name       => name+' -'+author,
    :price      => price,
    :fullprice  => fullprice,
    :guid       => guid,
    :picture    => picture,
    :url        => 'http://www.ziwi.co.nz/one_day_deals.php',
    :published  => published,
    :home       => 'Ziwi',
    :home_url   => 'http://www.ziwi.co.nz/one_day_deals.php',
    :rank       => 10,
    :stock      => stock

        )
        end  
  end
end
end




  
