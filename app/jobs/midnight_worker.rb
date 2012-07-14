class MidnightWorker
  def perform
    GroupyWorker.new.perform
    GraboneWorker.new.perform
    TreatmeWorker.new.perform
  end
end