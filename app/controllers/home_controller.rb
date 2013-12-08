class HomeController < ApplicationController
  def login
      @email = params[:email]
      @pwd = params[:password]
      #@flag = false
      
    
      if @email != "" && @pwd != "" && @email && @pwd
	@flag = false
	tmp = Users.find(:first, :conditions => [ "lower(email) = ?", params[:email].downcase])
	if tmp
	if tmp.email.downcase == @email.downcase && tmp.password == @pwd 
	  cookies.signed[:email] = {:value => tmp.email, :expires => Time.now + 1.hour}
	@msg = cookies.signed[:email]
	redirect_to(:action=>"profile", :controller=>"main")
      elsif !Users.find_by_email(@email) || !Users.find_by_password(@pwd)
	@flag = true
	@msg = "Wrong user name or password"
      end
      else 
	@flag = true
        @msg = "Wrong user name or password"	
      end	
      @flag = false
      end

    
  end

  def logout
    email = cookies.signed[:email]
    if email
      cookies.delete(:email)
      redirect_to(:action=>"login", :controller=>"home")
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
    
    
  end

  def lost_password
	@email = params[:email]
	#@flag = false
	@msg = ""
	@user = Users.find_by_email(@email)
	if @email
		if @user
			@msg = "Your password has been sent to your email"
             	  	message = "Subject:Password Reminder!\n\nThe password for user: " + @email + " is: " + @user.password
               		smtp = Net::SMTP.new 'smtp.gmail.com', 587
            		smtp.enable_starttls
               		smtp.start('gmail.com','innovationcredits@gmail.com', 'practicumewallet2013', :login) do
                	smtp.send_message(message, "innovationcredits@gmail.com", @email)
			end
			flag = true
		else
			@msg = "This mail doesn't exist"
			flag = true
		end
	else
		flag = false
	end	
  end
end
