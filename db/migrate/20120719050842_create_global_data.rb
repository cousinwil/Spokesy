class CreateGlobalData < ActiveRecord::Migration
  def change
    create_table :global_data do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
