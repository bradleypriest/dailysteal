desc "Fetch DailyDo"
task :fetch_dailydo => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  @urls = ['wellington', 'bop', 'hamilton', 'whangarei', 'dunedin', '', 'christchurch']      
  @urls.each do |url|
        item = Nokogiri::HTML(open('http://dailydo.co.nz/'+url))
        picture = item.at_css("#div_results td td td img")[:src]
        published  = (Time.now+12.hours).hour>=9? Date.today+21.hours : Date.today-3.hours
        guid = picture[/\d+/]+(published.strftime(fmt='%d%m%g'))
        href = url.present? ?  url : 'auckland'
          unless Coupon.exists? :guid => guid 
            description = item.at_css(".normaltext div").text
              Coupon.create!(
              :description => description,
              :price      => description[/\$[\d,\.]+/],
              :url        => 'http://www.dailydo.co.nz'+url,
              :picture    => 'http://www.dailydo.co.nz/'+picture,
              :published  => published,
              :location   => href,
              :home       => 'Dailydo',
              :home_url   => 'http://www.dailydo.co.nz',
              :guid       =>  guid,
              :rank       =>  8,
              :stock      => 100
                  )
     end
   end
end





