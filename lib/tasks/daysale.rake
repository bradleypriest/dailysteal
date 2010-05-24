desc "Fetch daysale Prices"
task :fetch_daysale => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://daysale.co.nz"
  doc = Nokogiri::HTML(open(url))   
  doc.css(".smallprod_table , .mainprod_content").each do |item|  
    href = item.at_css(".mainprod_manu a, .smallprod_manu a")[:href]
  
  doc = Nokogiri::HTML(open(href))  
    doc.css("#mainWrapper").each do |item|  
        name = item.at_css("h3").text
        price = item.at_css(".productSpecialPrice2").text[/\$[\d,]+\.\d\d/]
        fullprice = item.at_css(".normalprice2").text[/\$[\d,]+\.\d\d/]
       picture = item.at_xpath('//img[@title]')[:src]

            
unless FeedEntry.exists? :name => name
    FeedEntry.create!(
    :name       => name,
    :price      => price,
    :fullprice  => fullprice,
    :url        => href,
    :guid       => href[/\d+(?=.html)/],
    :picture    => 'http://www.daysale.co.nz/'+picture,
    :published  => (Time.now.hour+12)>12? Date.today+24.hours : Date.today,
    :home       => 'Daysale',
    :home_url   => 'http://daysale.co.nz',
    :rank       =>  9

        )
      end   
    end
  end

end



  