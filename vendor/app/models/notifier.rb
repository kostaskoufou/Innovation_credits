class Notifier < ActionMailer::Base
  default :from => 'innovationcredits@gmail.com'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(user,message)
    @user = user
    mail( :to => @user,
    :subject => 'Invitation to Innovation Credits',
    :body => message )
  end
end
