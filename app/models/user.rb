class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :maintenances, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :posts, class_name: 'Post', dependent: :destroy
  has_many :maintenance_comments
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
  scope :without_guest, -> { where.not(email: "guest@example.com") }

  scope :active,  -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  default_scope { where(deleted_at: nil) }

  def soft_delete
    transaction do
      update!(deleted_at: Time.current)
  
      owned_groups.each do |group|
        group.soft_delete
      end
    end
  end

  def restore
    update(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end

  def active_for_authentication?
    super && !deleted?
  end

  def inactive_message
    deleted? ? :deleted_account : super
  end

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
    owned_groups.include?(group)
  end
end