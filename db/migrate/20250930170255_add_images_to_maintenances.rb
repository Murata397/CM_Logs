class AddImagesToMaintenances < ActiveRecord::Migration[6.1]
  def change
    add_column :maintenances, :images, :string
  end
end

# これいらないモデル