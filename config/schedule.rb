set :output, path+'/log/cron.log'

set :job_template, nil

every 1.day, :at => '12.02 am' do
  runner "GroupyWorker.enqueue"
  runner "GraboneWorker.enqueue"
  runner "SpreetsWorker.enqueue"
  runner "TreatmeWorker.enqueue"
end

every 1.day, :at => '9.02 am' do
  runner "DailydoWorker.enqueue"
end
every 1.day, :at => '10.02 am' do
  runner "DealadayWorker.enqueue"
  runner "TrademeWorker.enqueue"
  #runner "ZiwiWorker.enqueue"
end

every 1.day, :at => '11.01 am' do
  runner "SnatchadealWorker.enqueue"
end

every 1.day, :at => '12.01 pm' do
  runner "OneDayWorker.enqueue"
  runner "SixShooterWorker.enqueue"
  runner "ThreeDealsWorker.enqueue"
  #runner "MightyApeWorker.enqueue"
  runner "DaysaleWorker.enqueue"
  runner "CrazysalesWorker.enqueue"
end

every '15,45 * * * *' do
 runner "StockWorker.enqueue"
end

