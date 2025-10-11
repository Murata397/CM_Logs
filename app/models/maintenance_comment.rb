class MaintenanceComment < ApplicationRecord
  belongs_to :user
  belongs_to :maintenance
  
  validates :comment, presence: true
end
