desc "Fetch 1-day Prices"
task :fetch_snatchadeal => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.snatchadeal.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css(".box").each do |item|
       url = item.at_css(".box-image a")[:href][/.+(?=&)/]
        published  = (Time.now+12.hours).hour>=11? Date.today+23.hours : Date.today-1.hours
        guid = url[/\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid
      name = item.at_css(".pageHeading2").text
      price = item.at_css(".discount-price").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".rrp").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css(".box-image img")[:src].gsub(/\s/,'%20')
  doc = Nokogiri::HTML(open(url))
      stock = doc.at_css("#product-info-right img")[:title][/\d+/]
        
            
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => url,
      :picture    => 'http://www.snatchadeal.co.nz/'+picture,
      :published  => published,
      :home       => 'Snatchadeal',
      :home_url   => 'http://www.snatchadeal.co.nz/',
      :guid       =>  guid,
      :rank       =>  5,
      :stock      => stock
      )
    
    end
  end
end
