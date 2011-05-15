desc "Fetch Grabone"
task :fetch_grabone => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.grabone.co.nz/"

  doc = Nokogiri::HTML(open(url))  
      doc.css(".deal").each do |item|
        picture = item.at_css(".deal-image img")[:src]
        published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
        guid = picture[/\d\w+(?=\.jpg)/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid 
          name =  item.at_css(".deal-heading").text
          url = item.at_css(".link-overlay")[:href]
          locations = url[/\w+/]
          if locations == 'auckland'
            location = 1
          elsif locations =='wellington'
            location = 2
          elsif locations =='christchurch'
            location = 3
          elsif locations =='dunedin'
            location = 4
          elsif locations =='hamilton'
            location = 5
          elsif locations =='tauranga'
            location = 6
            elsif locations =='waikato'
              location = 7
            elsif locations == 'northland'
              location =8
            else
              location = 10
          end
      #description = doc.at_css(".shadow-box-green").text
      #price = doc.at_css(".big-price").text
          Coupon.create!(
          :name => name,
       # :description => description,
          :price      => name[/^\$[\d,]+/],
          :url        => 'http://www.grabone.co.nz'+url,
          :picture    => picture,
          :published  => published,
          :location_id   => location,
          :home       => 'Grabone',
          :home_url   => 'http://www.grabone.co.nz',
          :guid       =>  guid,
          :rank       =>  4,
          :stock      => 100
            )
        end
      end
end




