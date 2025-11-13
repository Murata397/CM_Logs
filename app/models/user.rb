class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenances, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :posts, class_name: 'Post', dependent: :destroy
  has_many :maintenance_comments, dependent: :destroy
  has_many :fuel_efficiency, dependent: :destroy
  has_one_attached :profile_image
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :requests
  has_many :owned_groups, foreign_key: 'owner_id', class_name: 'Group'



  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "Guest"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

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
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  def group_joined?(group)
    groups.include?(group)
  end

  def is_owner_of?(group)
    self.owned_groups.include?(group)
  end
end