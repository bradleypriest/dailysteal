class DailydoWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  @urls = [ '','wellington','christchurch','dunedin','hamilton','bop' ]
  @urls.each_with_index do |url, i|
        item = Nokogiri::HTML(open('http://dailydo.co.nz/'+url))
        picture = item.at_css("#div_tabresults td td td img")[:src]
        published = PublishTime.new( 9 ).time
        guid = picture[/\d+/]+(published.strftime(fmt='%d%m%g'))
        href = url.present? ?  url : 'auckland'
        picture = picture[0..3] == "http" ? picture : 'http://www.dailydo.co.nz/'+picture
          unless Coupon.exists? :guid => guid
            description = item.at_css(".normaltxt").text
              Coupon.create!(
              :description => description,
              :price      => description[/\$[\d]+/],
              :url        => 'http://www.dailydo.co.nz/'+href,
              :picture    => picture,
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


