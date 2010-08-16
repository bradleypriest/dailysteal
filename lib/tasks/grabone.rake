desc "Fetch DailyDo"
task :fetch_grabone => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.grabone.co.nz/auckland"
  doc = Nokogiri::HTML(open(url))  
   
      picture = doc.at_css(".main-image img")[:src]
      published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
      guid = picture[/\d\w+/]+(published.strftime(fmt='%d%m%g'))
      unless Coupon.exists? :guid => guid 
      name =  doc.at_css("#dealShow h1").text.gsub("Today's deal: ", "")
      description = doc.at_css(".shadow-box-green").text
      price = doc.at_css(".big-price").text
        Coupon.create!(
        :name => name,
        :description => description,
        :price      => price,
        :url        => 'http://www.grabone.co.nz',
        :picture    => 'http://www.grabone.co.nz'+picture,
        :published  => published,
        :home       => 'Grabone',
        :home_url   => 'http://www.grabone.co.nz',
        :guid       =>  guid,
        :rank       =>  2,
        :stock      => 100
            )
      end

end




