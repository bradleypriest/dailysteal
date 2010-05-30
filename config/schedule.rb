every 1.day, :at => '12:04 am' do
#Ziwi   
  rake "fetch_ziwi" 
end
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
end

every 1.day, :at => '12:15 am' do
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
end

every 1.day, :at => '11:01 pm' do
#Snatchadeal
  rake "fetch_snatchadeal"
end

every 1.day, :at => '10:01 pm' do
#MightyApe
  rake "fetch_mightyape"
#Dealaday
  rake "fetch_dealaday"
#Gameaday
  rake "fetch_gameaday"
end

every 1.day, :at => '9:01 pm' do
#OffTheBack
  rake "fetch_otb"
end



every 1.day, :at => '12.01 pm' do
#TheDeal
  rake "fetch_thedeal"
#Yahoo
  rake "fetch_yahoo"
end

every 1.day, :at => '10.01 am' do
#NZHerald
  rake "fetch_nzh"
end

every 1.daym, :at '12.10am'
#Stock levels
  rake "fetch_stock"
end


every 20.minutes do
#Stock levels
  rake "fetch_stock"
end

