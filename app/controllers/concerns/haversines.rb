module Haversines
  def narrow_down_cabs(latitude:, longitude:)
    raise "Latitude and Longitude must be present in request" if latitude == nil or longitude == nil
    records = Driver.connection.select_all(sql(latitude, longitude)).to_hash
    return no_cabs_response if records.count == 0
    cabs_available_response(records)
  end
  
  def sql(latitude, longitude)
    %(SELECT name, car_number, phone_number, ( 6371000 * acos( cos( radians(#{latitude}) ) * cos( radians( latitude ) ) * cos( radians(longitude) - radians(#{longitude}) ) + sin( radians(#{latitude}) ) * sin( radians(latitude)))) AS distance 
      FROM
      (SELECT name, car_number, phone_number, latitude, longitude FROM DRIVERS  
      WHERE car_number IN (SELECT car_number 
      FROM DRIVERS
      WHERE latitude IS NOT NULL or longitude is NOT NULL)) WHERE distance < 4000 
      ORDER BY distance 
      LIMIT 0 , 20;  
    )
  end

  def no_cabs_response
    {
      "message": "No cabs available!"
    }
  end

  def cabs_available_response(records)
    records.each { |h| h.delete("distance") }
    {
      "available_cabs": records
    }
  end
end
