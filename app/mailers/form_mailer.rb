class FormMailer < ApplicationMailer
  default from: 'mails@feedyfy.com'

  def send_form_email(email, body, form_url, sender_id)
    @body = body
    @form_url = form_url
    mail(from: "#{sender_id} <mails@feedyfy.com>", to: email, subject: 'Your feedback matters to us!')
  end

end
