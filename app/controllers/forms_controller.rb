require 'net/smtp'

class FormsController < ApplicationController
  def invitation
    email = cookies.signed[:email]
    #Checks if the user is logged
    if email
      usr = Users.find_by_email(email)
      #Checks if the user is admin
      if usr.role == "Admin" || usr.role == "admin"
	@email = params[:email]
	@pwd = params[:password]
	@dep = params[:department]
	@rl = params[:role]
	
	#Registered Departments
	@deps = ["Actuarial", "Projects", "Corporate Services", "CRM", "Customer Operations",
	      "Finance","Financial Software Development", "Fund Accounting", "Fund Accounting BA",
	      "HR", "Innovation", "IT .Net Dev", "IT Architect", "IT Cloas Dev", "IT QA",
		"Operational Excellence & Control", "Risk & Compliance", "Sales"]
	#Registered Roles
	@roles = ["User","Department Leader","Admin"]
	
	if @email && @pwd && @rl && @dep && @email!="" && @pwd!=""
	  #regular expression to valid the email
	  mail_check = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/
	  
	  #The fagl variable is to return even an error or a success message
	  #flag = 0 when the user already exists
	  #flag = 1 the user has been created
	  #flag = 2 not a valid email
	  #flag = 3 all fields are required
	  
	  if mail_check =~ @email
	      #Checks if the user already exists
	      if Users.find_by_email(@email)
		  @msg = "The user already exists!"
		  @flag = 0
	      else
		#extracts the name from the email, using regular expression
		namegen = /^([^(\.|\_|\-)@]+)\.*\-*\_*([^@]*)/
		new_name = namegen.match(@email)
		#Creating new user
		@user = Users.create(:email => @email,:name => new_name[1] + " " + new_name[2], :password => @pwd, :role => @rl, :department => @dep, 
				    :avail_chips => 100, :given_chips => 0, :received_chips => 0)
		@msg = Users.find(:last)
		@flag = 1
		
		#Send's the invitation to the resitered email
		message = "Subject:Innovation Credits Invitation!\n\nYou can login to Innovation Credits with user name: " + @email + " and password: " + @pwd 

		smtp = Net::SMTP.new 'smtp.gmail.com', 587
    		smtp.enable_starttls
    		smtp.start('gmail.com','innovationcredits@gmail.com', 'practicumewallet2013', :login) do
      		smtp.send_message(message, "innovationcredits@gmail.com", @email)
    end


	      end
	  else
	      @msg = "Not a valid email address"
	      @flag = 2
	  end
	else
	  @flag = 3
	  @msg = "All fields are required!"
	end
      #If the user is not admin, he is redirected to the profile page
      else
	 redirect_to(:action=>"profile", :controller=>"main")
      end
    #If the user is not logged, he will not visit the page and he will be redirected to the login page 
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end

  
  
  def registration
  #This is the Contro Panel of the user, where he can change the name, the password and the profile photo  
    email = cookies.signed[:email]
    #Check's if the user is logged
    if email
      @name = params[:name]
      @npwd = params[:password]
      @file = params[:upload]
      
      
      #Searching the user details and updating them
      @user = Users.find_by_email(email)
      if @name && @name != ""
	@user.update_attributes(:name => @name)
      elsif @npwd && @npwd != ""
	@user.update_attributes(:password => @npwd)
      elsif @name && @name != "" && @npwd && @npwd != ""
	@user.update_attributes(:name => @name, :password => @npwd)
      end
	
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
#TODO: UPLOAD PROFILE IMAGE
=begin    
    if @file
      @file_name = Dir[File.join(Dir.home, '**', @file)]  
    end
    
   
  
   # File.open(@file_name, 'wb') do |f|
   #   f.write params[:user][:picture].read
   # end
    
    #@temp = @user.name.to_string + " " + @user.email + " " + @user.password 
=end    

    
  end
end
