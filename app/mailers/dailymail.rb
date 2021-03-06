class Dailymail < ActionMailer::Base
  default :from => "Daily Steal <mailer@dailysteal.co.nz>"
  def daily_mailer(user)
    @feeds = FeedEntry.where('published >= ?', Date.today-24.hours).where('name LIKE ?', "%#{user.keyword}%")
    if @feeds.count    
      mail(:to => user.email, :subject => "Daily Steal daily deals for #{Date.today}")
    end
  end
end
