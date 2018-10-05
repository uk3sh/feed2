class SubmissionMailer < ApplicationMailer
  default from: 'Feedyfy <mails@feedyfy.com>'

  def submission_notification(email)
    mail(to: email, subject: 'You have a new feedback!')
  end
end
