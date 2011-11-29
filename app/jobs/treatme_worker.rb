class TreatmeWorker < DJ::Worker
  def perform
  require 'nokogiri'
  require 'open-uri'
  @urls = ["/Auckland", "/Wellington", "/Christchurch","/Otago", "/Tauranga", "/Waikato" ]
  @urls.each_with_index do |url, i|
    doc = Nokogiri::HTML(open("http://www.treatme.co.nz"+url))
      published = PublishTime.new( 0 ).time
      if doc.at_css("#buyButton a")
        guid = doc.at_css("#buyButton a")[:href].split('=')[1]+(published.strftime(fmt='%d%m%g'))
      else
        guid = nil
      end
      unless !guid || Coupon.exists?(:guid => guid)
        picture = doc.at_css("#colMain .colRight img")[:src]
        name =  doc.at_css("#colMain h1").text
        description = doc.at_css("#voucherDescription").text.strip
        price =  doc.at_css("#buy .title h2 span").text
        if i == 5
          i = 7
        end
        Coupon.create!(
        :name       => name,
        :description => description,
        :price      => price.strip,
        :url        => "http://www.treatme.co.nz"+url,
        :picture    => picture,
        :published  => published,
        :location_id => i+1,
        :home       => 'Treatme',
        :home_url   => "http://www.treatme.co.nz",
        :guid       =>  guid,
        :rank       =>  2,
        :stock      => 100
        )
    end
  end
end


end