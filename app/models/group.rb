class Group < ApplicationRecord
  has_many_attached :group_image
  belongs_to :owner, class_name: 'User'

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  has_many :requests, dependent: :destroy

  validates :group_name, presence:true
  validates :group_introduction, presence:true
  validates :group_introduction, length: { maximum: 100 }
  validates :group_rules, length: { maximum: 200 }

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

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(group_name: content)
    elsif method == 'forward'
      Group.where('group_name LIKE ?', content + '%')
    elsif method == 'backward'
      Group.where('group_name LIKE ?', '%' + content)
    else
      Group.where('group_name LIKE ?', '%' + content + '%')
    end
  end

end
