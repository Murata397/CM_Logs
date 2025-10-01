class AddToolImagesToMaintenances < ActiveRecord::Migration[6.1]
  def change
    add_column :maintenances, :tool_images, :json
  end
end
