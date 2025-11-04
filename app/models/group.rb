class Group < ApplicationRecord
  has_many_attached :group_image
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy

  validates :group_name, presence:true
  validates :group_introduction, presence:true

  def get_group_image
    if group_image.attached?
      group_image
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end

  def is_owner_by?(user)
    owner.id == user.id
  end
end
