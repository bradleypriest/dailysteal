#every 1.day, :at => '12:04 am' do
#Ziwi   
#  rake "fetch_ziwi" 
#end

every 1.day, :at => '12.01 am' do
#Daysale
  rake "fetch_daysale"
#6Shooter
  rake "fetch_6shooter"
#Catchoftheday
  rake "fetch_catchoftheday"
#3deals
  rake "fetch_3deals"  
#1-day
  rake "fetch_1day"
#1-daytee
#  rake "fetch_1daytee"
#Crazysales
  rake "fetch_crazysales"
#MightyApe
  rake "fetch_mightyape"
end

every 1.day, :at => '12:16 am' do
#Ziwi   
  rake "fetch_ziwi" 
#Daysale
  rake "fetch_daysale"
#6Shooter
  rake "fetch_6shooter"
#Catchoftheday
  rake "fetch_catchoftheday"
#3deals
  rake "fetch_3deals"  
#1-day
  rake "fetch_1day"
#1-daytee
#  rake "fetch_1daytee"
#Crazysales
  rake "fetch_crazysales"
#MightyApe
  rake "fetch_mightyape"
end

every 1.day, :at => '11:01 pm' do
#Snatchadeal
  rake "fetch_snatchadeal"
end

every 1.day, :at => '10:01 pm' do
#Dealaday
  rake "fetch_dealaday"
#Gameaday
  rake "fetch_gameaday"
#Trademe
  rake "fetch_trademe"
end

every 1.day, :at => '9:01 pm' do
#OffTheBack
  rake "fetch_otb"
end

every 1.day, :at => '12:03 pm' do
#TheDeal
  rake "fetch_thedeal"
#Yahoo
#  rake "fetch_yahoo"
end

#every 1.day, :at => '10.01 am' do
#NZHerald
#  rake "fetch_nzh"
#end

#every 1.day, :at => '12.10am' do
#Stock levels
#  rake "fetch_stock"
#end


#every 30.minutes do
#Stock levels
#  rake "fetch_stock"
#end

