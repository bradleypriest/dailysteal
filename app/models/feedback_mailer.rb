class FeedbackMailer < ActionMailer::Base
  
  def feedback(feedback)
    @recipients  = 'bradleypriest@gmail.com'
    @from        = 'noreply@dailysteal.com'
    @subject     = "[Feedback for YourSite] #{feedback.subject}"
    @sent_on     = Time.now
    @body[:feedback] = feedback    
  end

end
