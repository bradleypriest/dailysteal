class DealadayWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  url = "http://www.dealaday.co.nz"
  doc = Nokogiri::HTML(open(url))

  doc.css("#deal").each do |item|
    picture = item.at_css("#mainimage")[:src]
    published = PublishTime.new( 10 ).time
    guid = item.at_css(".dealTitle a")[:onclick][/\d+/]+(published.strftime(fmt='%d%m%g'))
    unless FeedEntry.exists? :guid => guid
      name = item.at_css(".dealTitle a").text
      name2 = item.at_css(".dealSubtitle").text
      price = item.at_css(".ourPrice p").text[/\$[\d,]+\.\d\d/]
      fullprice = item.at_css(".whyPay td.r").text[/\$[\d,]+\.\d\d/]
      stock = 100

    FeedEntry.create!(
      :name       => name+' '+name2,
      :price      => price,
      :fullprice  => fullprice,
      :picture    => picture,
      :url        => 'http://www.dealaday.co.nz',
      :guid       => guid,
      :home       => 'Dealaday',
      :home_url   => 'http://www.dealaday.co.nz/',
      :published  => published,
      :rank       => 6,
      :stock      => stock


      )
    end
  end
end
end