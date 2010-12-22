desc "Fetch Lets get it"
task :fetch_letsgetit => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  @urls = ['auckland']
    @urls.each_with_index do |url, i|
    doc = Nokogiri::HTML(open("http://www.letsgetit.co.nz/city/"+url))
        published  = (Time.now).hour>=12 ? Date.today+12.hours : Date.today-12.hours
        guid = doc.at_css('#deal-intro h1 a')[:href][/\d+/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid 
          picture = doc.at_css("#deal-intro .side img")[:src]
          name =  doc.at_css("#deal-intro h1").text.strip
          description = doc.at_css("#deal-stuff .box-content .main .blk").text.strip
          price =  doc.at_css("#deal-intro p.deal-price strong").text

          Coupon.create!(
          :name       => name,
          :description => description,
          :price      => price,
          :url        => "http://www.letsgetit.co.nz/city/"+url,
          :picture    => picture,
          :published  => published,
          :location_id => i+1,
          :home       => 'Lets Get It',
          :home_url   => 'http://www.letsgetit.co.nz',
          :guid       =>  guid,
          :rank       =>  9,
          :stock      => 100
            )
        end
    end
end


