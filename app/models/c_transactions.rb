class CTransactions < ActiveRecord::Base
  attr_accessible :chips, :comment, :from, :to
end
