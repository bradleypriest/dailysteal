set :output, path+'/log/cron.log'
job_type :curl, "curl http://www.dailysteal.co.nz/touch/:task :output"

set :job_template, nil

every 1.day, :at => '12.05am' do
  curl "groupy"
  curl "grabone"
  curl "spreets"
  curl "treatme"
end

every 1.day, :at => '9.02am' do
  curl "dailydo"
end
every 1.day, :at => '10.02am' do
  curl "dealaday"
  curl "trademe"
  #curl "ziwi"
end

every 1.day, :at => '11.02am' do
  curl "snatchadeal"
end

every 1.day, :at => Time.now.at_beginning_of_day+12.hours+4.minutes do
  curl "midday"
end

every '15,45 * * * *' do
 curl "stock"
end

#curl "mighty_ape"
