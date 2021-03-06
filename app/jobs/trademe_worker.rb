class TrademeWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  url = "http://www.trademe.co.nz/daily-deals/"
  doc = Nokogiri::HTML(open(url))

    doc.css(".deal-gallery-card").each do |item|
      url = item.at_css(".deal-margin a")[:href]
      published = PublishTime.new( 10 ).time
      guid = url[/\d+/]+(published.strftime(fmt='%d%m%g'))
      unless FeedEntry.exists? :guid => guid
        name = item.at_css(".deal-margin a").text
        price = item.at_css(".deal-price").text[/\$[\d,]+\.\d\d/]
        fullprice = item.at_css(".deal-meta").text[/\$[\d,]+\.\d\d/]
        picture = item.at_css(".deal-image img")[:src]
        stock = item.at_css("#DailyDealsStockMeter div")[:class][/\d+/]


    FeedEntry.create!(
      :name       => name,
      :price      => price,
      :fullprice  => fullprice,
      :url        => 'http://www.trademe.co.nz'+url,
      :picture    => picture,
      :published  => published,
      :home       => 'Trademe',
      :home_url   => 'http://www.trademe.co.nz/daily-deals/',
      :guid       => guid,
      :rank       => 2,
      :stock      => stock

      )
    end
  end
end
end
