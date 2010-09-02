desc "Fetch Groupy"
task :fetch_groupy => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  @urls = ["auckland","wellington" ]
  @urls.each do |url|
  doc = Nokogiri::HTML(open("http://www.groupy.co.nz/"+url))  
        published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
        guid = doc.at_css(".btn_buy")[:href][/\d+/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid 
          picture = doc.at_css(".boxee_mask img")[:src]
          name =  doc.at_css(".deal_title").text
      description = doc.at_css("#detailsContainer").text.strip
      price =  doc.at_css("#buyContainer h1").text
          Coupon.create!(
          :name       => name.gsub("Today's Deal: ", ""),
          :description => description,
          :price      => price[/\$[\d,]+/],
          :url        => 'http://www.groupy.co.nz/'+url,
          :picture    => picture,
          :published  => published,
          :location   => url,
          :home       => 'Groupy',
          :home_url   => 'http://www.groupy.co.nz',
          :guid       =>  guid,
          :rank       =>  3,
          :stock      => 100
            )
        end
      end
end


