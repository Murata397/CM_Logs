class CreateMaintenances < ActiveRecord::Migration[6.1]
  def change
    create_table :maintenances do |t|
      t.string :title, null: false, default: ""
      t.date :date, null: false, default: nil
      t.string :task, null: false, default: ""
      t.string :difficulty
      t.string :tool_images
      t.integer :time
      t.time :price
      t.string :related_information
      t.text :work_description
      t.boolean :is_active
      
      t.timestamps
    end
  end
end
