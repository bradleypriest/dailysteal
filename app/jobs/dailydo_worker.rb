class DailydoWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  @urls = [ '','wellington','christchurch','dunedin','hamilton','bop' ]
  @urls.each_with_index do |url, i|
        item = Nokogiri::HTML(open('http://dailydo.co.nz/'+url))
        picture = item.at_css("#div_tabresults td td td img")[:src]
        published  = (Time.now+12.hours).hour>=9? Date.today+21.hours : Date.today-3.hours
        guid = picture[/\d+/]+(published.strftime(fmt='%d%m%g'))
        href = url.present? ?  url : 'auckland'
          unless Coupon.exists? :guid => guid
            description = item.at_css(".normaltext div").text
              Coupon.create!(
              :description => description,
              :price      => description[/\$[\d]+/],
              :url        => 'http://www.dailydo.co.nz/'+url,
              :picture    => 'http://www.dailydo.co.nz/'+picture,
              :published  => published,
              :location_id  => i+1,
              :home       => 'Dailydo',
              :home_url   => 'http://www.dailydo.co.nz',
              :guid       =>  guid,
              :rank       =>  8,
              :stock      => 100
                  )
     end
   end
end


end


