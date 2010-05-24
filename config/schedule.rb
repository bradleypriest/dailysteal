every 1.day, :at => '12:02 am' do
  #Ziwi   
    rake "fetch_ziwi" 
end
every 1.day, :at => '7.18 am' do
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
end

every 1.day, :at => '9:01 pm' do
#OffTheBack
  rake "fetch_otb"
end


#TheDeal
every 1.day, :at => '12.01 pm' do
  rake"fetch_thedeal"
end
