class FeedbackMailer < ActionMailer::Base
  
  def feedback(feedback)
    @recipients  = 'bradleypriest@gmail.com'
    @from        = 'feedback@dailysteal.com'
    @subject     = "[Feedback for Dailysteal] #{feedback.subject}"
    @sent_on     = Time.now
    @body[:feedback] = feedback    
  end

end
