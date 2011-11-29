class CouponWorker
  def self.enqueue
    DailydoWorker.enqueue
    GraboneWorker.enqueue
    GroupyWorker.enqueue
    TreatmeWorker.enqueue
  end

end