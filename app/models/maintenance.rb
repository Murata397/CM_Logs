class Maintenance < ApplicationRecord

  belongs_to :user
  belongs_to :car
  has_many_attached :images, dependent: :destroy
  has_one_attached :tool_images, dependent: :destroy
  has_many :work_descriptions, dependent: :destroy
  has_many :maintenance_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :maintenance_day, presence: true
  validates :maintenance, presence: true
  validates :work_difficulty, presence: true

  def index
    @maintenances = Maintenance.select(:id, :title, :maintenance_day, :maintenance, :work_difficulty)
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

  def self.search_for(content, method)
    if method == 'perfect'
      Maintenance.joins(:car).where('maintenances.title LIKE ? OR cars.car_name LIKE ?', "%#{content}%", "%#{content}%")
    elsif method == 'forward'
      Maintenance.joins(:car).where('maintenances.title LIKE ? OR cars.car_name LIKE ?', "#{content}%", "#{content}%")
    elsif method == 'backward'
      Maintenance.joins(:car).where('maintenances.title LIKE ? OR cars.car_name LIKE ?', "%#{content}", "%#{content}")
    else
      Maintenance.joins(:car).where('maintenances.title LIKE ? OR cars.car_name LIKE ?', "%#{content}%", "%#{content}%")
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end