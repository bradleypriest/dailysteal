require 'rubygems'  
require 'nokogiri'  
require 'open-uri'  
  
url = "http://www.1-day.co.nz"
doc = Nokogiri::HTML(open(url))  
doc.css(".content_prod").each do |item|  
  text = item.at_css("h1").text
  price = item.at_css("h2").text
  puts "#{text}#{price}"
end