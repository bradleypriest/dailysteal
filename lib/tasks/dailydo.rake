desc "Fetch DailyDo"
task :fetch_dailydo => :environment do
  require 'rubygems'  
  require 'nokogiri'  
  require 'open-uri'
  url = "http://www.dailydo.co.nz"
  doc = Nokogiri::HTML(open(url))  
   
      picture = doc.at_css("#div_results td td td img")[:src]
      published  = (Time.now+12.hours).hour>=9? Date.today+21.hours : Date.today-3.hours
      guid = picture[/\d+/]+(published.strftime(fmt='%d%m%g'))
      unless Coupon.exists? :guid => guid 
      description = doc.at_css(".normaltext div").text
        Coupon.create!(
        :description => description,
        :price      => description[/\$[\d,\.]+/],
        :url        => 'http://www.dailydo.co.nz',
        :picture    => 'http://www.dailydo.co.nz/'+picture,
        :published  => published,
        :home       => 'DailyDo',
        :home_url   => 'http://www.dailydo.co.nz',
        :guid       =>  guid,
        :rank       =>  2,
        :stock      => 100
            )
      end

end




