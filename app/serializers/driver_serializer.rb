class DriverSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number, :license_number, :car_number
end
