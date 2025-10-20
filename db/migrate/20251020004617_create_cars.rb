class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|

      t.integer :user_id
      t.string :manufacturer_name
      t.string :car_name
      t.string :odometer
      t.string :purpose
      t.timestamps
    end
  end
end
