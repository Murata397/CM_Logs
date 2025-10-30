class CreateFuelEfficiencies < ActiveRecord::Migration[6.1]
  def change
    create_table :fuel_efficiencies do |t|

      t.integer :user_id
      t.integer :car_id
      t.string :title, default: "", null: false
      t.date :refuelin_day, default: ""
      t.string :odometer, default: ""
      t.string :tripmeter, default: "", null:false
      t.string :fuel, default: "", null: false
      t.string :fuel_efficiency, default: "", null: false
      t.string :fuel_type, default: ""
      t.timestamps
    end
  end
end
