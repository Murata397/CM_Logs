class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenances, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :posts, class_name: 'Post', dependent: :destroy
  has_many :maintenance_comments, dependent: :destroy
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

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backword'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
end