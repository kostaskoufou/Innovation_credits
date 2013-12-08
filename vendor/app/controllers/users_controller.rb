class UsersController < ApplicationController
  def users_list
    email = cookies.signed[:email]
    if email
      @user = Users.find_by_email(email)
      @nm = @user.name
      @cout = Help.find(:all, :order => "created_at DESC")
      @usrs = Users.find(:all, :order => "name")
      
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end


  def charts
    email = cookies.signed[:email]
    if email
      @user = Users.find_by_email(email)
      @nm = @user.name
      @cout = Help.find(:all, :order => "created_at DESC")
      @usrs = Users.find(:all)
      
      #chart for user's department transactions
=begin      
@deps = ["Actuarial", "Projects", "Corporate Services", "CRM", "Customer Operations",
	      "Finance","Financial Software Development", "Fund Accounting", "Fund Accounting BA",
	      "HR", "Innovation", "IT .Net Dev", "IT Architect", "IT Cloas Dev", "IT QA",
		"Operational Excellence & Control", "Risk & Compliance", "Sales"]	  

      receivers = []
      pout2 = CTransactions.find(:all,:conditions => {:from => @user.id})
      pout2.each do |p|
	receivers << p.to
      end
      receivers.uniq.each do |r|
	usr = Users.search_by_id(r)
	if usr.department == "Actuarial"
	  actuarial +=  
	elsif
=end
      
      #Line chart which compares sent and received credits of the user in a year per month
      #Calculation for receives per month (by using an array)
      rmonth = []
      rmonth[0] = 0
      rmonth[1] = 0
      rmonth[2] = 0
      rmonth[3] = 0
      rmonth[4] = 0
      rmonth[5] = 0
      rmonth[6] = 0
      rmonth[7] = 0
      rmonth[8] = 0
      rmonth[9] = 0
      rmonth[10] = 0
      rmonth[11] = 0
      pout = CTransactions.find(:all,:conditions => {:to => @user.id})
      pout.each do |p|
	if p.created_at.month == 1
	  rmonth[0] += p.chips
	elsif p.created_at.month == 2
	  rmonth[1] += p.chips
	elsif p.created_at.month == 3
	  rmonth[2] += p.chips
	elsif p.created_at.month == 4
	  rmonth[3] += p.chips
	elsif p.created_at.month == 5
	  rmonth[4] += p.chips
	elsif p.created_at.month == 6
	  rmonth[5] += p.chips	  
	elsif p.created_at.month == 7
	  rmonth[6] += p.chips
	elsif p.created_at.month == 8
	  rmonth[7] += p.chips
	elsif p.created_at.month == 9
	  rmonth[8] += p.chips
	elsif p.created_at.month == 10
	  rmonth[9] += p.chips
	elsif p.created_at.month == 11
	  rmonth[10] += p.chips
	elsif p.created_at.month == 12
	  rmonth[11] += p.chips	 
	end
      end
      #Calculation for sents per month (by using an array)
      pout2 = CTransactions.find(:all,:conditions => {:from => @user.id})
      smonth = []
      smonth[0] = 0
      smonth[1] = 0
      smonth[2] = 0
      smonth[3] = 0
      smonth[4] = 0
      smonth[5] = 0
      smonth[6] = 0
      smonth[7] = 0
      smonth[8] = 0
      smonth[9] = 0
      smonth[10] = 0
      smonth[11] = 0
      pout2.each do |p|
	if p.created_at.month == 1
	  smonth[0] += p.chips
	elsif p.created_at.month == 2
	  smonth[1] += p.chips
	elsif p.created_at.month == 3
	  smonth[2] += p.chips
	elsif p.created_at.month == 4
	  smonth[3] += p.chips
	elsif p.created_at.month == 5
	  smonth[4] += p.chips
	elsif p.created_at.month == 6
	  smonth[5] += p.chips	  
	elsif p.created_at.month == 7
	  smonth[6] += p.chips
	elsif p.created_at.month == 8
	  smonth[7] += p.chips
	elsif p.created_at.month == 9
	  smonth[8] += p.chips
	elsif p.created_at.month == 10
	  smonth[9] += p.chips
	elsif p.created_at.month == 11
	  smonth[10] += p.chips
	elsif p.created_at.month == 12
	  smonth[11] += p.chips	 
	end
      end
	#@line_char = Gchart.line(:data => [month[0], month[1], month[2], month[3], month[4], month[5], month[6], month[7],month[8], month[9], month[10]. month[11]], :axis_with_labels => 'x,r',
         #   :axis_labels => [['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],['10','20','30','40','50','60','70','80','100']])
	
   months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
   prices = [5,10,15,20,25,30,35,40,45,50]
   other = [5,10,15,20,25,30,35,40,45,50]
   
	@line_chart = Gchart.line(:data => [[rmonth[0], rmonth[1], rmonth[2], rmonth[3], rmonth[4], rmonth[5], rmonth[6], rmonth[7], rmonth[8], rmonth[9], rmonth[10], rmonth[11]],
	                                    [smonth[0], smonth[1], smonth[2], smonth[3], smonth[4], smonth[5], smonth[6], smonth[7], smonth[8], smonth[9], smonth[10], smonth[11]]], 
	                          :line_colors => "FF0000,00FF00", :axis_with_labels => 'y,x,r',
	                          :axis_labels => [other,prices,months])
	  



      
      #@line_chart = Gchart.pie_3d(:title => 'ruby_fu', :size => '400x200',
       #       :data => [month[0], month[1], month[2], month[3], month[4], month[5], month[6], month[7],month[8], month[9], month[10]. month[11]], :labels => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'] )
      
      
      
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
    
  end
end
