class MiddayWorker
  def self.enqueue
    OneDayWorker.enqueue
    SixShooterWorker.enqueue
    ThreeDealsWorker.enqueue
    DaysaleWorker.enqueue
    CrazysalesWorker.enqueue
  end
end