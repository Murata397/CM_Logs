class AddDeletedAtToGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :deleted_at, :datetime
  end
end
