desc "Fetch dealaday Prices"
task :fetch_dealaday => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.dealaday.co.nz"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css("#deal").each do |item| 
      picture = item.at_css("#mainimage")[:src] 
      published  = (Time.now+12.hours).hour>=10? Date.today+22.hours : Date.today-2.hours
      guid = item.at_css("#buynow_daily a")[:href][/\d+/]+(published.strftime(fmt='%d%m%g'))
  unless FeedEntry.exists? :guid => guid
      name = item.at_css("#dealLeft .dealTitle a").text
      name2 = item.at_css("#dealLeft .dealSubtitle").text 
      price = item.at_css("#dealRight .ourPrice p").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css("#dealRight table td.r").text[/\$[\d,]+\.\d\d/]
      stock = item.at_css("#productstatus tr td")[:width][/\d+/].to_i
          
    FeedEntry.create!(
      :name       => name+' '+name2,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => picture,
      :url        => 'http://www.dealaday.co.nz',
      :guid       => guid,
      :home       => 'Dealaday',
      :home_url   => 'http://www.dealaday.co.nz/',
      :published  => published,
      :rank       => 6,      
      :stock      => stock


      )
    end
  end
end