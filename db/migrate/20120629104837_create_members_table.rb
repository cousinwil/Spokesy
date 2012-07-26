class CreateMembersTable < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :strava_id
      t.string  :user_name
      t.string  :user_id
      t.string 	:club_id
      
      t.timestamps
    end
  end
end