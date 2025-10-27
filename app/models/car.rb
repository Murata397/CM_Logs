class Car < ApplicationRecord
  belongs_to :user
  has_many :maintenances

  has_one_attached :car_image

  validates :car_image, presence: true
  validates :manufacturer_name, presence: true
  validates :car_name, presence: true
  validates :car_model, presence: true
  validates :odometer, presence: true
  validates :purpose, presence: true


  def self.search_for(content, method)
    if method == 'perfect'
      Car.where("car_name LIKE ? OR manufacturer_name LIKE ?", content, content)
    elsif method == 'forward'
      Car.where('car_name LIKE ? OR manufacturer_name LIKE ?', content + '%', content + '%')
    elsif method == 'backward'
      Car.where('car_name LIKE ? OR manufacturer_name LIKE ?', '%' + content, '%' + content)
    else
      Car.where('car_name LIKE ? OR manufacturer_name LIKE ?', '%' + content + '%', '%' + content + '%')
    end
  end
end