class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|

      t.integer :user_id
      t.string :car_image
      t.string :manufacturer_name, null: false
      t.string :car_model, null: false
      t.string :odometer, null: false
      t.string :purpose, null: false
      t.timestamps
    end
  end
end