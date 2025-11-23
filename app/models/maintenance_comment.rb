class MaintenanceComment < ApplicationRecord
  belongs_to :user
  belongs_to :maintenance
  
  validates :comment, presence: true

  default_scope { where(deleted_at: nil) }
  scope :with_deleted, -> { unscope(where: :deleted_at) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end
end
