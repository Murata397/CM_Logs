class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner_id
      t.integer :car_id
      t.string :group_name
      t.text :group_introduction

      t.timestamps
    end
  end
end
