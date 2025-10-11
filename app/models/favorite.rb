class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :maintenance
  validates_uniqueness_of :maintenance_id, scope: :user_id
end
