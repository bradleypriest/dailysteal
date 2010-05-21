class FeedbackMailer < ActionMailer::Base
  
  def feedback(feedback)
    @recipients  = 'bradleypriest@gmail.com'
    @from        = 'noreply@dailysteal.com'
    @subject     = "[Feedback for DailySteal] #{feedback.subject}"
    @sent_on     = Time.now
    @body[:feedback] = feedback    
  end

end
