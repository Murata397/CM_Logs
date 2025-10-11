class CreateMaintenanceComments < ActiveRecord::Migration[6.1]
  def change
    create_table :maintenance_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :maintenance_id

      t.timestamps
    end
  end
end
