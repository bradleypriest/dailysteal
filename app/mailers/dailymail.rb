class Dailymail < ActionMailer::Base
  default :from => "Daily Steal <mailer@dailysteal.co.nz>"
  def daily_mailer(user)
    @search = user.keyword
    mail(:to => user.email, :subject => "Daily Steal daily deals for #{Date.today}")
  end
end
