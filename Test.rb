require 'rubygems'
require 'open-uri'
require 'nokogiri'
 
doc = Nokogiri::HTML(open("http://daysale.co.nz/pocket-mist-3pack-p-594.html"))
doc.xpath('//img[@title]').each do |node|
   
   puts node[:src]

end
