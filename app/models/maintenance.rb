class Maintenance < ApplicationRecord

  belongs_to :user
  has_many_attached :images

  validates :title, presence: true
  validates :maintenance_day, presence: true
  validates :maintenance, presence: true

end


def index
  @maintenances = Maintenance.select(:id, :title, :maintenance_day, :maintenance)
end