class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenances
  has_many :posts, class_name: 'Post'
  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
end