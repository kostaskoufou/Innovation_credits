#This is a help class, which is used on Leaderboards, where it used to store name and the sum credits
class Top_Sum
  attr_accessor :name, :sum_credits
  def initialize(name, sum_credits)
	    @name = name
	    @sum_credits = sum_credits
  end
end

class MainController < ApplicationController
  def profile
    email = cookies.signed[:email]
    if email
      @user = Users.find_by_email(email)
      @nm = @user.name
      @cout = Help.find(:all, :order => "created_at DESC")
      
      #Credits that have been received from the current user
      @pout = CTransactions.find(:all,:conditions => {:to => @user.id})

      #Credits that have been sent from the current user
      @pout2 = CTransactions.find(:all,:conditions => {:from => @user.id})
      
	a = CTransactions.find_by_to(40)
	CTransactions.delete(a)
      
      #Set's the credits every year
      if Time.utc(2013).year == Time.now.year
	time = 2013
      elsif time != Time.now.year
	old_time = time
	time = Time.now.year
	@user = Users.find_by_email(email)
	@user.update_attributes(:avail_chips => 100, :given_chips => 0, :received_chips => 0)
      end
      
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end

  def send_chips
    email = cookies.signed[:email]
    if email
      #Retrieve help requests
      @hout = Help.find(:all, :order => "created_at DESC")
      #Current User
      @user = Users.find_by_email(email)
      @nm = @user.name
      search = params[:search]
      if search
	@cout = []
	@tmp = Users.find(:all)
	@tmp.each do |s|
	  if s.name!=nil && s.name.downcase.include?(search.downcase) && search != "" && s.department != @user.department && s.id != @user.id
	     @cout << s
	  end
	end
      end
      @chips = params[:chips].to_i
      @usr = params[:usr]
      @reason = params[:reason]
      if @chips && @user.avail_chips
	if @chips > @user.avail_chips
	  then @msg = "Not enough credits!"
	else
	  #Update's current user chips
	  @user.update_attributes(:given_chips => @user.given_chips + @chips, :avail_chips => @user.avail_chips - @chips)
	
	  @to_usr = Users.find_by_id(@usr)
	  if @to_usr
	    #Update's "to user" chips
	    @to_usr.update_attributes(:received_chips => @to_usr.received_chips + @chips, :avail_chips => @to_usr.avail_chips + @chips)
	    #Store's transactions
	    @tran = CTransactions.create(:to => @to_usr.id, :from => @user.id, :comment => @reason, :chips => @chips)
	  end
	end
      end
    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end    

  def leaderboard
        email = cookies.signed[:email]
    if email
      @user = Users.find_by_email(email)
      @nm = @user.name
      @cout = Help.find(:all, :order => "created_at DESC")

      #top user's of received chips      
      @top_rec = Users.find(:all, :order => "received_chips desc", :limit => 3)
      #Finding the postion of the current user (for recieved chips)
      @pot_rec = Users.find(:all, :order => "received_chips desc")
      temp = 0
      @c1 = 0
      @pot_rec.each do |pt|
	temp += 1
	if @user.id == pt.id
	  @c1 = temp
	end
      end

      #top user's of given chips      
      @top_sent = Users.find(:all, :order => "given_chips desc", :limit => 3)
      #Finding the postion of the current user (for given chips)
      @pot_sent = Users.find(:all, :order => "given_chips desc")
      temp = 0
      @c2 = 0
      @pot_sent.each do |pt|
	temp += 1
	if @user.id == pt.id
	  @c2 = temp
	end
      end
      
      #top user's of summerized chips (given+receieved)
      @top_sum = []
      a_top_sum = Users.find(:all)

      a_top_sum.each do |s|
	@top_sum << Top_Sum.new(s.name, s.received_chips + s.given_chips)
      end
      @new = @top_sum.sort_by { |hsh| hsh.sum_credits }.reverse
      
      temp = 0
      @c3 = 0
      @new.each do |pt|
	temp += 1
	if @user.name == pt.name
	  @c2 = temp
	  @my_sum = pt.sum_credits
	end
      end


    else
      redirect_to(:action=>"login", :controller=>"home")
    end
  end
end
