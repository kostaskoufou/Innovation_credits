class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :from
      t.string :to
      t.text :comment

      t.timestamps
    end
  end
end
