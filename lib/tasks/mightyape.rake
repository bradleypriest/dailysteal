desc "Fetch MightyApe Prices"
task :fetch_mightyape => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.mightyape.co.nz/daily-deals/"
  doc = Nokogiri::HTML(open(url))  
    
    doc.css(".deal").each do |item|  
      url = item.at_css(".title .title")[:href]
      published  = (Time.now+12.hours).hour>=10? Date.today+22.hours : Date.today-2.hours
      guid = url[/\d\d\d\d\d+/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid
      name = item.at_css(".title .title").text
      price = item.at_css(".price .price").text
      fullprice = item.at_css(".old").text
      picture = item.at_css(".boxshot")[:src]
      stock = item.at_xpath('div[@class="dealBox"]/div')[:class][/\d+/]


    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => 'http://www.mightyape.co.nz'+url,
      :picture    => picture,
      :published  => published,
      :home       => 'MightyApe',
      :home_url   => 'http://www.mightyape.co.nz/daily-deals/',
      :guid       => guid,
      :rank       => 11,
      :stock      => stock

      )
    end
  end
end
