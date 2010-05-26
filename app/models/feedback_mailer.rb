class FeedbackMailer < ActionMailer::Base
  
  def feedback(feedback)
    @recipients  = 'admin@dailysteal.co.nz'
    @from        = 'feedback@dailysteal.co.nz'
    @subject     = "[Feedback for Dailysteal] #{feedback.subject}"
    @reply_to    = "#{feedback.email}"
    @sent_on     = Time.now
    @body[:feedback] = feedback    
  end

end
