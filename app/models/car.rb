class Car < ApplicationRecord
  belongs_to :user

  has_one_attached :car_image

  validates :car_image, presence: true
  validates :manufacturer_name, presence: true
  validates :car_model, presence: true
  validates :odometer, presence: true
  validates :purpose, presence: true

end