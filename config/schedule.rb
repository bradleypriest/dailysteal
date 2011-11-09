set :output, path+'/log/cron.log'

set :job_template, nil

every 1.day, :at => '12.05am' do
  runner "GroupyWorker.enqueue"
  runner "GraboneWorker.enqueue"
  runner "SpreetsWorker.enqueue"
  runner "TreatmeWorker.enqueue"
end

every 1.day, :at => '9.02am' do
  runner "DailydoWorker.enqueue"
end
every 1.day, :at => '10.02am' do
  runner "DealadayWorker.enqueue"
  runner "TrademeWorker.enqueue"
  #runner "ZiwiWorker.enqueue"
end

every 1.day, :at => '11.02am' do
  runner "SnatchadealWorker.enqueue"
end

every 1.day, :at => Time.now.at_beginning_of_day+12.hours+4.minutes do
  runner "OneDayWorker.enqueue"
  runner "SixShooterWorker.enqueue"
  runner "ThreeDealsWorker.enqueue"
  runner "DaysaleWorker.enqueue"
  runner "CrazysalesWorker.enqueue"
end

every '15,45 * * * *' do
 runner "StockWorker.enqueue"
end

#runner "MightyApeWorker.enqueue"
