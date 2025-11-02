class FuelEfficiency < ApplicationRecord
  
  belongs_to :user
  belongs_to :car

  validates :tripmeter, presence: true
  validates :fuel, presence: true
end

def calculate_fuel_efficiency
  fuel_efficiency = @fuel_efficiency.fuel.to_f / @fuel_efficiency.tripmeter.to_f
  @fuel_efficiency.update_attribute(:fuel_efficiency, fuel_efficiency.to_s)
end