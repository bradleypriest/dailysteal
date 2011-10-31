class SpreetsWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  root = Nokogiri::HTML(open("http://www.spreets.co.nz/home/Auckland"))
    href = root.css('ul.sub_menu li a').each_with_index do |url,i|
      doc = Nokogiri::HTML(open(url[:href]))
      if doc.at_css("#thedeal a")
        published  = (Time.now).hour>=12 ? Date.today+12.hours : Date.today-12.hours
        guid = doc.at_css('#thedeal a')[:href][/\d+/]+(published.strftime(fmt='%d%m%g'))
        unless Coupon.exists? :guid => guid
          picture = doc.at_css("#thedeal .dealInfo img")[:src]
          name =  doc.at_css("#announcement h1").text.strip
          description = doc.at_css("#dealbominfodesc").text.strip
          price =  doc.at_css(".dealDetails .dealPrice h2").text

          Coupon.create!(
          :name       => name,
          :description => description,
          :price      => price.strip,
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


