class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :date
      t.integer :miles
      t.integer :club_id
      t.timestamps
    end
  end
end
