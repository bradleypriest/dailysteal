desc "Fetch 6 Shooter Prices"
task :fetch_6shooter => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.6shooter.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
  doc.css(".s_prod_hold_1 , .s_prod_hold_2").each do |item|  
    name = item.at_css(".s_prod_info p").text
    name2 = item.at_css("h1").text
    price = item.at_css("h2").text[/\$[\d,]+\.\d\d/]
    url = item.at_css("a")[:href]
    picture = item.at_css(".s_prod_image img")[:src].gsub(/\s/,'%20')
    fullprice = item.at_css(".s_prod_info h3").text[/\$[\d,]+\.\d\d/]

  
unless FeedEntry.exists? :guid => url[/\d+/]

  FeedEntry.create!(
  :name       => name2+' '+name,
  :price      => price,
  :fullprice  => fullprice,
  :url        => 'http://www.6shooter.co.nz'+url,
  :picture    => picture,
  :published  => (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours,
  :home       => '6Shooter',
  :home_url   => 'http://www.6Shooter.co.nz/',
  :guid       =>  url[/\d+/],
  :stock      =>  100,
  :rank       =>  3
      )
    end
  end
end




