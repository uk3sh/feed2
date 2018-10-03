class FormMailer < ApplicationMailer
  default from: 'mails@feedyfy.com'

  def send_form_email(email, body, form_url, from_email)
    @body = body
    @form_url = form_url
    mail(from: "<#{from_email}>", to: email, subject: 'Your feedback matters to us!')
  end

end
