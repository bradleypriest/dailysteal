class OneDayWorker < DJ::Worker
  require 'nokogiri'
  require 'open-uri'
  def perform
    url = "http://www.1-day.co.nz"
    doc = Nokogiri::HTML(open(url))

    doc.css(".content_prod").each do |item|
      url = item.at_css(".home_top img")[:src][/\/products.+(?=_small)/]
      published  = (Time.now+12.hours).hour>=12? Date.today : Date.today-24.hours
      guid = url.gsub(/\/products\//,'')+(published.strftime(fmt='%d%m%g'))

      unless FeedEntry.exists? :guid => guid
        name = item.at_css(".productTitle").text.gsub(/\s+/,' ')
        price = item.at_css(".pricing li:nth-child(2)").text
        fullprice = item.at_css(".why_pay li").text.gsub(/WHY\sPAY\s/,'')
        href = 'http://www.1-day.co.nz'+url
        doc = Nokogiri::HTML(open(href))
          stock = doc.at_css(".stock_bar script").text[/\d+(?=',\s\/\/)/]

          FeedEntry.create!(
            :name       => name[/\w.+/],
            :price      => price,
            :fullprice  => fullprice,
            :url        => href,
            :picture    => 'http://www.1-day.co.nz/images'+url+'_small.jpg',
            :published  => published,
            :home       => '1-day',
            :home_url   => 'http://www.1-day.co.nz/',
            :guid       =>  guid,
            :rank       =>  1,
            :stock      => stock

          )
      end
    end
  end
end

