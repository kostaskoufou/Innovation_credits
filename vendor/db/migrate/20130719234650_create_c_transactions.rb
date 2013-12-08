class CreateCTransactions < ActiveRecord::Migration
  def change
    create_table :c_transactions do |t|
      t.integer :from
      t.integer :to
      t.string :comment
      t.integer :chips

      t.timestamps
    end
  end
end
