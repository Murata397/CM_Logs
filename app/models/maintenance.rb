class Maintenance < ApplicationRecord

  enum is_active: { draft: false, published: true }

  belongs_to :user
  belongs_to :car
  has_many_attached :images, dependent: :destroy
  has_one_attached :tool_images, dependent: :destroy
  has_many :work_descriptions, dependent: :destroy
  has_many :maintenance_comments
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :maintenance_day, presence: true
  validates :maintenance, presence: true
  validates :work_difficulty, presence: true

  default_scope { where(deleted_at: nil) }
  scope :with_deleted, -> { unscope(where: :deleted_at) }

  def soft_delete
    update_column(:deleted_at, Time.current)
  end

  def restore
    update_column(:deleted_at, nil)
  end

  def deleted?
    deleted_at.present?
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