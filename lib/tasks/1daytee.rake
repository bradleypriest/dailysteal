desc "Fetch 1daytee Prices"
task :fetch_1daytee => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.1-daytee.co.nz"
  doc = Nokogiri::HTML(open(url))
      picture = doc.at_css("#placeholder")[:src] 
      published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
      guid = picture[/\w+(?=_)/]+(published.strftime(fmt='%d%m%g'))

  unless FeedEntry.exists? :guid => guid
    
      name = doc.at_css("h1").text 
      price = doc.at_xpath('//img[@height="71"]')[:src][/\d\d\.\d\d/]
      stock = doc.at_css(".newsletter2Font td:nth-child(1) img")[:alt][/\d+/]
      
    FeedEntry.create!(
      :name       => name,
      :price      => '$'+price,
      :picture    => 'http://www.1-daytee.co.nz'+picture,
      :url        => 'http://www.1-daytee.co.nz',
      :guid       => guid,
      :home       => '1-daytee',
      :home_url   => 'http://www.1-daytee.co.nz',
      :published  => published,
      :rank       => 14,      
      :stock      => stock


      )
    
  end
end