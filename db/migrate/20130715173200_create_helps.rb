class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :name
      t.string :reason
      t.string :department
      t.string :priority

      t.timestamps
    end
  end
end
