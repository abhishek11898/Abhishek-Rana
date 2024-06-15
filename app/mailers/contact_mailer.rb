class ContactMailer < ApplicationMailer
  default from: 'abhishekgugle@gmail.com'

  def contact_email(full_name, email, message)
    @full_name = full_name
    @message = message
    mail(to: 'abhishekgugle@gmail.com', subject: 'New Contact Form Message', reply_to: email)
  end
end

  