namespace :user do
  desc "Send daily email"
  task :send_mail => :environment do
    user = User.first
    Dailymail.daily_mailer(user).deliver
  end
end