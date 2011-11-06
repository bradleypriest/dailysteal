class SixShooterWorker < DJ::Worker

  def perform
    require 'nokogiri'
    require 'open-uri'
    url = "http://www.6shooter.co.nz"
    doc = Nokogiri::HTML(open(url))

    doc.css(".s_prod_hold_1 , .s_prod_hold_2").each do |item|
      url = item.at_css("a")[:href]
      published = PublishTime.new( 12 ).time
      guid = url[/\d+/]+(published.strftime(fmt='%d%m%g'))
      unless FeedEntry.exists? :guid => guid

          name = item.at_css(".s_prod_info p").text
          name2 = item.at_css("h1").text
          price = item.at_css("h2").text[/\$[\d,]+\.\d\d/]
          picture = item.at_css(".s_prod_image img")[:src].gsub(/\s/,'%20')
          fullprice = item.at_css(".s_prod_info h3").text[/\$[\d,]+\.\d\d/]
          if item.at_css(".s_prod_sold").nil?
            stock = 100
          else
            stock = 0
          end

        FeedEntry.create!(
        :name       => name2+' '+name,
        :price      => price,
        :fullprice  => fullprice,
        :url        => 'http://www.6shooter.co.nz'+url,
        :picture    => picture,
        :published  => published,
        :home       => '6Shooter',
        :home_url   => 'http://www.6Shooter.co.nz/',
        :guid       =>  guid,
        :stock      =>  stock,
        :rank       =>  3
            )
          end
        end
    end
end



