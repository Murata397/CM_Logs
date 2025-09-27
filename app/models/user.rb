class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenances
  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :introduction, length: { maximum: 50 }
  
  def profile_image_url
    if profile_image.attached?
      profile_image.variant(resize: '500x500').processed.url
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
end