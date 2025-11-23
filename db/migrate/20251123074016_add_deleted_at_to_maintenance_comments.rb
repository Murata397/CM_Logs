class AddDeletedAtToMaintenanceComments < ActiveRecord::Migration[6.1]
  def change
    add_column :maintenance_comments, :deleted_at, :datetime
  end
end
