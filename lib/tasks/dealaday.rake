desc "Fetch dealaday Prices"
task :fetch_dealaday => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.dealaday.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#product_main").each do |item|  
      name = item.at_css(".vt:nth-child(1) h1").text
      name2 = item.at_css("h2:nth-child(2)").text 
      price = item.at_css("h2.di").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css("h3:nth-child(4)").text[/\$[\d,]+\.\d\d/]
      url = item.at_css("img:nth-child(3)")[:href]
      picture = item.at_css("img:nth-child(3)")[:src] 
      stock = item.at_css(".orange")[:style][/\d\d/]
      
      
unless FeedEntry.exists? :name => name+' '+name2    
    FeedEntry.create!(
      :name       => name+' '+name2,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => 'http://www.dealaday.co.nz/'+picture.gsub('large','medium'),
      :url        => 'http://www.dealaday.co.nz',
      :guid       => picture[/\d+/],
      :home       => 'Dealaday',
      :home_url   => 'http://www.dealaday.co.nz/',
      :published  => (Time.now+12.hours).hour>=10? Date.today+22.hours : Date.today-2.hours,
      :rank       => 6,      
      :stock      => stock


      )
    end
  end
end