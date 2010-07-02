desc "Fetch daysale Prices"
task :fetch_daysale => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://daysale.co.nz"
  doc = Nokogiri::HTML(open(url))   
  doc.css(".smallprod_table , .mainprod_content").each do |item|  
    href = item.at_css(".mainprod_manu a, .smallprod_manu a")[:href][/.+html/]
    published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
    guid = href[/\d+(?=.html)/]+(published.strftime(fmt='%d%m%g'))
unless FeedEntry.exists? :guid => guid
  doc = Nokogiri::HTML(open(href))  
    doc.css("#mainWrapper").each do |item|  
        name = item.at_css(".prodinfo_manu").text
        name2 = item.at_css("#productName").text
        price = item.at_css(".productSpecialPrice2, .prodinfotoday_pay").text[/\$[\d,]+\.\d\d/]
      unless item.at_css(".normalprice2").nil?
        fullprice = item.at_css(".normalprice2").text[/\$[\d,]+\.\d\d/]
      end
        picture = item.at_xpath('//img[@title]')[:src].gsub(/\s/,'%20')
      unless item.at_css(".stockdiv").nil? 
        stock = item.at_css(".stockdiv img")[:src][/\d+/]
      else
        stock = 0
      end

    FeedEntry.create!(
    :name       => name+' '+name2,
    :price      => price,
    :fullprice  => fullprice,
    :url        => href,
    :guid       => guid,
    :picture    => 'http://daysale.co.nz/'+picture,
    :published  => published,
    :home       => 'Daysale',
    :home_url   => 'http://daysale.co.nz',
    :rank       => 9,
    :stock      => stock

        )
      end   
    end
  end

end



  
