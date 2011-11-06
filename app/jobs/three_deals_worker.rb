class ThreeDealsWorker < DJ::Worker
  def perform
    require 'nokogiri'
    require 'open-uri'
    url = "http://www.3deals.co.nz/site/index.php"
    doc = Nokogiri::HTML(open(url))

    doc.css("#hp-product-detail-middle table, td:nth-child(3) .navigation-product table, #home-list td:nth-child(2) .navigation-product table").each do |item|
      href = item.at_css("a")[:href]
      published = PublishTime.new( 12 ).time
      guid = href[/deal-\w+/].split('-')[1]+(published.strftime(fmt='%d%m%g'))
      unless FeedEntry.exists? :guid => guid
          url = 'http://www.3deals.co.nz/site/'+href
           doc = Nokogiri::HTML(open(url))
           doc.css("#product-detail").each do |item|
             name = item.at_css("#allImages p:nth-child(1)").text.capitalize
             name2 = item.at_css("h1").text
             price = item.at_css("#priceFront").text
             picture = item.at_css("#mainImage")[:src]
             unless item.at_css(".dontPay").nil?
               fullprice = item.at_css(".dontPay").text[/\$[\d,]+\.\d\d/]
             end
            stock = item.xpath('//img[@alt]').detect{ |img| img[:alt] =~ /Stock/ }[:alt][/\d+/]+'0'

        FeedEntry.create!(
        :name       => name+' '+name2,
        :price      => price,
        :fullprice  => fullprice,
        :url        => url,
        :picture    => 'http://www.3deals.co.nz/site/'+picture,
        :published  => published,
        :home       => '3Deals',
        :home_url   => 'http://www.3Deals.co.nz/',
        :guid       =>  guid,
        :rank       =>  4,
        :stock      => stock

            )
        end
      end
    end
  end
end




