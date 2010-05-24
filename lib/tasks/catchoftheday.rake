desc "Fetch catchoftheday Prices"
task :fetch_catchoftheday => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.catchoftheday.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#rightcol").each do |item|  
      name = item.at_css("#catch_name").text
      name2 = item.at_css("h2").text 
      price = item.at_css("#price").text[/\$[\d,]+\.\d\d/]
   #   fullprice = item.at_css("h3:nth-child(4)").text[/\$[\d,]+\.\d\d/]
      picture = item.at_css("#main_image")[:src] 
unless ProductEntry.exists? :guid => name    
    ProductEntry.create!(
      :name       => name+' '+name2,
      :price      => price,
#      :fullprice  => fullprice,
      :picture    => 'http://www.catchoftheday.co.nz/'+picture,
      :published  => (Time.now.hour+12)>12? Date.today+24.hours : Date.today,
      :url          => 'http://www.catchoftheday.co.nz',
      :guid         => name,
      :home         => 'Catchoftheday',
      :home_url     => 'http://www.catchoftheday.co.nz',
      :rank         => 7

      )
    end
  end
end