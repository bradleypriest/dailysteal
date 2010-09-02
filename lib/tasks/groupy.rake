desc "Fetch Grabone"
task :fetch_grabone => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.grabone.co.nz/"
  doc = Nokogiri::HTML(open(url))  
      doc.css(".deal-left, .deal-right").each do |item|
        picture = item.at_css(".deal-image img")[:src]
        published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
        guid = picture[/\d\w+(?=\.jpg)/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid 
          name =  item.at_css(".active-deal a").text
          url = item.at_css(".active-deal a")[:href]
      #description = doc.at_css(".shadow-box-green").text
      #price = doc.at_css(".big-price").text
          Coupon.create!(
          :name => name,
       # :description => description,
          :price      => name[/^\$[\d,]+/],
          :url        => 'http://www.grabone.co.nz'+url,
          :picture    => 'http://www.grabone.co.nz'+picture,
          :published  => published,
          :location   => url[/\w+/],
          :home       => 'Grabone',
          :home_url   => 'http://www.grabone.co.nz',
          :guid       =>  guid,
          :rank       =>  2,
          :stock      => 100
            )
        end
      end
end




