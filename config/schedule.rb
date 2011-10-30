set :output, path+'/log/cron.log'
job_type :rake,    "cd :path && RAILS_ENV=:environment bin/rake :task --silent :output"

every 1.day, :at => '12.03 am' do
  rake "fetch_groupy"
end
every 1.day, :at => '12.04 am' do
  rake "fetch_grabone"
end
every 1.day, :at => '12.06 am' do
  rake "fetch_spreets"
end
every 1.day, :at => '12.07 am' do
  rake "fetch_treatme"
end
every 1.day, :at => '9.02 am' do
  rake "fetch_dailydo"
end
every 1.day, :at => '10.02 am' do
  rake "fetch_dealaday"
end
every 1.day, :at => '10.03 am' do
  rake "fetch_trademe"
end
# every 1.day, :at => '10.05 am' do
#   rake "fetch_ziwi"
# end
every 1.day, :at => '11.01 am' do
  rake "fetch_snatchadeal"
end
every 1.day, :at => '12.01 pm' do
  rake "fetch_1day"
end
every 1.day, :at => '12.02 pm' do
  rake "fetch_6shooter"
end
every 1.day, :at => '12.03 am' do
  rake "fetch_3deals"
end
every 1.day, :at => '12.04 am' do
  rake "fetch_mightyape"
end
every 1.day, :at => '12.05 pm' do
  rake "fetch_daysale"
end
every 1.day, :at => '12.06 pm' do
  rake "fetch_crazysales"
end

#Stock
every 1.day, :at => '12.10am' do
 rake "fetch_stock"
end

every '15,45 * * * *' do
 rake "fetch_stock"
end

