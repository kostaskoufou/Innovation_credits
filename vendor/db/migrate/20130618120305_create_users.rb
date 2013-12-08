class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :organization
      t.string :department
      t.string :name
      t.string :role
      t.string :email
      t.string :password
      t.binary :picture
      t.integer :given_chips
      t.integer :received_chips
      t.integer :avail_chips

      t.timestamps
    end
  end
end
