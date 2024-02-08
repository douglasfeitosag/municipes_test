class CitizenMailer < ApplicationMailer
  def email
    email = params[:email]
    @message = params[:message]

    mail(to: email, subject: @message)
  end
end
