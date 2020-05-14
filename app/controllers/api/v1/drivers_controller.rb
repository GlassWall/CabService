module Api
  module V1
    class DriversController < ApplicationController
      def register
        @driver = Driver.create!(driver_params)
        json_response(@driver, :created)
      end

      def send_location
        @driver = Driver.find(params[:id])
        @driver.update_location = true
        @driver.update!(location_params)
        json_response(nil, :accepted)
      end
      private

      def driver_params
        # whitelist params
        params.permit(:name, :email, :phone_number, :license_number, :car_number)
      end

      def location_params
        params.permit(:latitude, :longitude)
      end
    end
  end
end
