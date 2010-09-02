desc "Fetch 1dayout"
task :fetch_1dayout => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  @urls = ["/10/title/Auckland","/11/title/Waikato%20/%20BOP", "/12/title/Wellington", "/13/title/Christchurch" ]
  @urls.each do |url|
  doc = Nokogiri::HTML(open("http://www.1-dayout.co.nz/dealLocation"+url))  
        picture = doc.at_css(".image_holder img")[:src]
        published  = (Time.now).hour>=12? Date.today+12.hours : Date.today-12.hours
        guid = picture[/\w+(?=_large)/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid 
          name =  doc.at_css(".productTitle h1").text.strip
      description = doc.at_css(".description").text.strip
      price =  doc.at_css(".getit_button p").text
          Coupon.create!(
          :name       => name,
          :description => description,
          :price      => '$'+price.strip,
          :url        => 'http://www.1-dayout.co.nz/dealLocation'+url,
          :picture    => 'http://www.1-dayout.co.nz'+picture,
          :published  => published,
          :location   => url[/\w\w\w\w\w\w+/].downcase,
          :home       => '1dayout',
          :home_url   => 'http://www.1-dayout.co.nz',
          :guid       =>  guid,
          :rank       =>  4,
          :stock      => 100
            )
        end
      end
end


