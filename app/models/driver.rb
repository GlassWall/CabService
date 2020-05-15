class Driver < ApplicationRecord
  attr_accessor :update_location
  validates :name, :email, :phone_number, :license_number, :car_number, presence: true
	validates_uniqueness_of :email, :phone_number, :license_number,:car_number
  validates_length_of :phone_number, is: 10
  validates :latitude, :longitude, presence: true, if: :update_location?
  
  
  private

  def update_location?
    update_location
  end
end
