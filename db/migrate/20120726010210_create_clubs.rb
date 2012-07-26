class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :club_id
      t.string :name
      t.string :twitter
      t.integer :admin_id
      t.string	:home_headline
      t.string 	:home_quote
      t.boolean :email_list
      t.string 	:mail_list_desc
      t.string 	:about_headline
      t.string 	:about_body
      t.string 	:copyright
      
      t.timestamps
    end
  end
end
