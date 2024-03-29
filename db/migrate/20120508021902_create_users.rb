class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin
      t.string :remember_token
      t.timestamps
    end
  end
end
