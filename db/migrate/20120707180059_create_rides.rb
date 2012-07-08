class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :athlete
      t.decimal :points
      t.decimal :speed
      t.decimal :vertical
      t.decimal :distance
      t.boolean :commute
      t.string :name
      t.date :date
      t.integer :ride_id
      t.timestamps
    end
  end
end
