desc "Fetch 1-day Prices"
task :fetch_snatchadeal => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.snatchadeal.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css(".box").each do |item|  
      name = item.at_css(".pageHeading2").text
      price = item.at_css(".discount-price").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".rrp").text[/\$[\d,]+\.\d\d/]
      url = item.at_css(".box-image a")[:href][/.+(?=&)/]
      picture = item.at_css(".box-image img")[:src].gsub(/\s/,'%20')
unless FeedEntry.exists? :name => name    
    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => url,
      :picture    => 'http://www.snatchadeal.co.nz/'+picture,
      :published  => (Time.now.hour-12)>11? Date.today+23.hours : Date.today-1.hours,
      :home       => 'Snatchadeal',
      :home_url   => 'http://www.snatchadeal.co.nz/',
      :guid       =>  url[/\d+/],
      :rank       =>  5

      )
    end
  end
end
