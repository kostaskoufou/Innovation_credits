class HelpController < ApplicationController
  def request_help
    email = cookies.signed[:email]
    if email
      @user = Users.find_by_email(email)
      @nm = @user.name
      
      #Registered Departments
      @deps = ["Actuarial", "Projects", "Corporate Services", "CRM", "Customer Operations",
	      "Finance","Financial Software Development", "Fund Accounting", "Fund Accounting BA",
	      "HR", "Innovation", "IT .Net Dev", "IT Architect", "IT Cloas Dev", "IT QA",
		"Operational Excellence & Control", "Risk & Compliance", "Sales"]
	
      #Message priority
      @prt = ["Normal","Urgent"]
      
      @help = params[:help]
      @dep = params[:department]
      @priority = params[:priority]
      
      if @help && @dep && @priority && @help != ""
	@post = Help.create(:name => @nm, :reason => @help, :department => @dep, :priority => @priority)
	@msg = "request successfully sent"
      else
	@msg = "All fields are required"
      end
      
      #Retrieve help requests
      @cout = Help.find(:all, :order => "created_at DESC")
      
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end
end
