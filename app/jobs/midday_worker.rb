class MiddayWorker
  def perform
    OneDayWorker.new.perform
    SixShooterWorker.new.perform
    ThreeDealsWorker.new.perform
    DaysaleWorker.new.perform
    CrazysalesWorker.new.perform
  end
end