class AddDeletedAtToMaintenances < ActiveRecord::Migration[6.1]
  def change
    add_column :maintenances, :deleted_at, :datetime
  end
end
