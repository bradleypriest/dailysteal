class SpreetsWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  root = Nokogiri::HTML(open("http://www.spreets.co.nz/home/Auckland"))
    href = root.css('ul.sub_menu li a').each_with_index do |url,i|
      doc = Nokogiri::HTML(open(url[:href]))
      if doc.at_css("a.button-buy")
        published  = (Time.now).hour>=12 ? Date.today+12.hours : Date.today-12.hours
        guid = doc.at_css('a.button-buy')[:href][/\d+/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid
          picture = doc.at_css(".media-container img")[:src]
          name =  doc.at_css(".body h1").text.strip
          description = nil #doc.at_css("#dealbominfodesc").text.strip
          price =  doc.at_css(".info b").text
          fullprice = doc.at_css(".fullprice b")

          Coupon.create!(
          :name       => name,
          :description => description,
          :price      => price.strip,
          :price      => fullprice.strip,
          :url        => url[:href],
          :picture    => picture,
          :published  => published,
          :location_id => 3-i,
          :home       => 'Spreets',
          :home_url   => 'http://www.spreets.co.nz',
          :guid       =>  guid,
          :rank       =>  5,
          :stock      => 100
            )
        end
      end
    end
end
end


