class CreateWorkDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :work_descriptions do |t|
      t.references :maintenance, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
