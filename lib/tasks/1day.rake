desc "Fetch 1-day Prices"
task :fetch_1day => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.1-day.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css(".content_prod").each do |item|  
      name = item.at_css(".productTitle").text.gsub(/\s+/,' ')
      price = item.at_css(".amount").text
      fullprice = item.at_css(".why_pay li").text.gsub(/WHY\sPAY\s/,'')
      url = item.at_css(".home_top img")[:src][/\/products.+(?=_small)/]  
unless ProductEntry.exists? :name => name    
    ProductEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => 'http://www.1-day.co.nz'+url,
      :picture    => 'http://www.1-day.co.nz/images'+url+'_small.jpg',
      :published  => (Time.now.hour+12)>12? Date.today+24.hours : Date.today,
      :home       => '1-day',
      :home_url   => 'http://www.1-day.co.nz/',
      :guid       =>  url.gsub(/\/products\//,''),
      :rank       =>  1

      )
    end
  end
end
