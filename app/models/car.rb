class Car < ApplicationRecord
  belongs_to :user

  validates :manufacturer_name, presence: true
  validates :car_model, presence: true
  validates :odometer, presence: true
  validates :purpose, presence: true

end