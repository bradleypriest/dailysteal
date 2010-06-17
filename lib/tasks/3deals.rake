desc "Fetch 3Deals Prices"
task :fetch_3deals => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.3deals.co.nz/site/index.php"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css("#hp-product-detail-middle , td:nth-child(3) .navigation-product, #home-list td:nth-child(2) .navigation-product").each do |item|  
    href = item.at_css("a")[:href]
    published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
    guid = href[/\d\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid
    url = 'http://www.3deals.co.nz/site/'+href
     doc = Nokogiri::HTML(open(url))  
     doc.css("#product-detail").each do |item|  
       name = item.at_css("#allImages p:nth-child(1)").text.capitalize
       name2 = item.at_css("h1").text
       price = item.at_css("#product-detail-price").text[/\$[\d,]+\.\d\d/]
       picture = item.at_css("#mainImage")[:src]
       unless item.at_css(("#do-not-pay")?
         fullprice = item.at_css("#do-not-pay").text[/\$[\d,]+\.\d\d/]
       end

       stock = item.at_xpath('//img[@height="30px"]')[:alt][/\d+/]+'0'
       
  FeedEntry.create!(
  :name       => name+' '+name2,
  :price      => price,
  :fullprice  => fullprice,
  :url        => url,
  :picture    => 'http://www.3deals.co.nz/site/'+picture,
  :published  => published,
  :home       => '3Deals',
  :home_url   => 'http://www.3Deals.co.nz/',
  :guid       =>  guid,
  :rank       =>  4,
  :stock      => stock

      )
    end   
  end
end
end




