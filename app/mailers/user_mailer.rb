class UserMailer < ApplicationMailer
  default from: 'notifications@slick.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:5173/signin'
    mail(to: @user.email, subject: 'Welcome to Slick!')
  end
end
