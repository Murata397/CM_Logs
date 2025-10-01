class CreateMaintenances < ActiveRecord::Migration[6.1]
  def change
    create_table :maintenances do |t|
      
      t.string :title, null: false, default: ""
      t.date :maintenance_day, null: false, default: nil
      t.string :maintenance, null: false, default: ""
      t.string :work_difficulty
      t.string :maintenance_tool
      t.integer :work_time
      t.decimal :work_pay
      t.string :related_information
      t.text :work_description
      t.boolean :is_active
      t.integer :user_id
      t.string :images
      t.json :tool_images

      t.timestamps
    end
  end
end
