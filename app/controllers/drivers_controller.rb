class DriversController < ApplicationController
  def register
    binding.pry
    p 1
    @driver = Driver.create!(driver_params)
    byebug
    json_response(@driver, :created)
  end

  private

  def driver_params
    # whitelist params
    params.permit(:name, :email, :phone_number, :license_number, :car_number)
  end

  def set_driver
    @driver = driver.find(params[:id])
  end
end
