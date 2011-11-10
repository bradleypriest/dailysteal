class QueueMaster
  def self.midday
    OneDayWorker.enqueue
    SixShooterWorker.enqueue
    ThreeDealsWorker.enqueue
    DaysaleWorker.enqueue
    CrazysalesWorker.enqueue
  end
end