class Maintenance < ApplicationRecord

  belongs_to :user
  has_many_attached :images
  has_one_attached :tool_images
  has_many :descriptions

  validates :title, presence: true
  validates :maintenance_day, presence: true
  validates :maintenance, presence: true

  def index
    @maintenances = Maintenance.select(:id, :title, :maintenance_day, :maintenance)
  end
  def get_tool_images
    if tool_images
      tool_images
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
  def get_images
    if images.attached?
      images
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
end