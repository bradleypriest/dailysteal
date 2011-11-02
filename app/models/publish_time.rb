class PublishTime
  attr_reader :time
  def initialize(hour)
    if Time.now.hour >= hour
      @time = Time.now.at_beginning_of_day+hour.hours
    else
      @time = Time.now.at_beginning_of_day-1.day+hour.hours
    end
  end
end