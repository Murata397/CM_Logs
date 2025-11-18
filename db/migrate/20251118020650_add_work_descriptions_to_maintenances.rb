class AddWorkDescriptionsToMaintenances < ActiveRecord::Migration[6.1]
  def change
    add_column :maintenances, :work_descriptions, :json
  end
end
