class Users < ActiveRecord::Base
  attr_accessible :avail_chips, :department, :email, :given_chips, :name, :organization, :password, :picture, :received_chips, :role
end
