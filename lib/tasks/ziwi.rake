desc "Fetch Ziwi Prices"
task :fetch_ziwi => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.ziwi.co.nz/one_day_deals.php"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css(".box_").each do |item|  
    href = item.at_css("a")[:href]
     doc = Nokogiri::HTML(open(href))  

       doc.css("#content form .box").each do |item|  
         name = item.at_css(".pageHeading b").text
         author = item.at_css(".title .bold").text.gsub(/\s+/,' ').gsub(',','&')
         price = item.at_css(".bold.black").text[/\$[\d,]+\.\d\d/]
         picture = item.at_css("#image img")[:src]
         fullprice = item.at_css(".strike").text[/\$[\d,]+\.\d\d/]


  unless FeedEntry.exists? :guid => href
    FeedEntry.create!(
    :name       => name+' by'+author,
    :price      => price,
    :fullprice  => fullprice,
    :guid       => href,
    :picture    => 'http://www.ziwi.co.nz/'+picture,
    :url        => 'http://www.ziwi.co.nz/one_day_deals.php',
    :published  => (Time.now.hour+12)>12? Date.today+24.hours : Date.today,
    :home       => 'Ziwi',
    :home_url   => 'http://www.ziwi.co.nz/one_day_deals.php',
    :rank       =>  10

        )
        end  
  end
end
end




  
