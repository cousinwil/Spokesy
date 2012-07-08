class AddIndexToMembers < ActiveRecord::Migration
  def change
    add_index :members, :strava_id, unique: true
    add_index :members, :user_id, unique: true    
  end
end
