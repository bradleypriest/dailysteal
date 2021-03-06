class SnatchadealWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  url = "http://www.snatchadeal.co.nz"
  doc = Nokogiri::HTML(open(url))

    doc.css(".home-daily-deal").each do |item|
      url = item.at_css("h2 a")[:href]
      if url[/\d+/].present?
        published = PublishTime.new( 11 ).time
        guid = url[/\d+/]+(published.strftime(fmt='%d%m%g'))
        name = item.at_css("h2 a").text
        unless FeedEntry.where('published > ?', 2.weeks.ago).where('name like ?', "#{name[0..8]}%" ).exists?
          price = item.at_css(".home-daily-deal-pricing").text[/\$[\d,]+\.\d\d/]
          fullprice = item.at_css(".home-daily-deal-rrp").text[/\$[\d,]+\.\d\d/]
          picture = item.at_css("img")[:src].gsub(/\s/,'%20')
          stock = doc.at_css(".home-daily-deal-buy-now") ? 100 : 0


          FeedEntry.create!(
            :name       => name,
            :price      => price,
            :fullprice  => fullprice,
            :url        => 'http://www.snatchadeal.co.nz/'+url,
            :picture    => 'http://www.snatchadeal.co.nz/'+picture,
            :published  => published,
            :home       => 'Snatchadeal',
            :home_url   => 'http://www.snatchadeal.co.nz/',
            :guid       =>  guid,
            :rank       =>  25,
            :stock      => stock
          )

        end
      end
    end
  end
end