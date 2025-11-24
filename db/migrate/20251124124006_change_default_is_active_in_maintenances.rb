class ChangeDefaultIsActiveInMaintenances < ActiveRecord::Migration[6.1]
  def change
    change_column_default :maintenances, :is_active, false
  end
end
