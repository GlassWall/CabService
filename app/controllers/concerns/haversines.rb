module Haversines
  def narrow_down_cabs(latitude:, longitude:)
    byebug
    radius = 4000 # todo put in .env
    multiplier = 1.1 #; // multiplier = 1.1; is more reliable
    p1_x = Calculator::DerivedPoints.new(lat: latitude, long: longitude, range: multiplier*radius, bearing: 0).calculate_derived_position.first
    p2_y = Calculator::DerivedPoints.new(lat: latitude, long: longitude, range: multiplier*radius, bearing: 90).calculate_derived_position.second
    p3_x = Calculator::DerivedPoints.new(lat: latitude, long: longitude, range: multiplier*radius, bearing: 180).calculate_derived_position.first
    p4_y = Calculator::DerivedPoints.new(lat: latitude, long: longitude, range: multiplier*radius, bearing: 270).calculate_derived_position.second
    # records = Driver.connection.select_all(the_sql(p1_x, p2_y, p3_x, p4_y)).to_hash
    byebug
    records = Driver.connection.select_all(sql(latitude, longitude)).to_hash
  end
  def sql(latitude,longitude)
    # %(
    #   SELECT *, 6371000 * acos(cos((Lat1 * #{(Math::PI / 180)}) ) * cos( (Lat2* #{(Math::PI / 180)} ) ) * cos( (Lng2* #{(Math::PI / 180)}) - (Lng1* #{(Math::PI / 180)}) ) + sin( (Lat1* #{(Math::PI / 180)}) ) * sin( (Lat2* #{(Math::PI / 180)})))) AS distance 
    #   FROM DRIVERS 
    #   HAVING distance < 4000 
    #   ORDER BY distance 
    #   LIMIT 0 , 20;
    # )
    %(
      SELECT id, ( 6371000 * acos( cos( radians(#{latitude}) ) * cos( radians( latitude ) ) * cos( radians(longitude) - radians(#{longitude}) ) + sin( radians(#{latitude}) ) * sin( radians(latitude)))) AS distance 
      FROM DRIVERS 
      HAVING distance < 4000 
      ORDER BY distance 
      LIMIT 0 , 20;
    )
  end
  def the_sql(p1_x, p2_y, p3_x, p4_y)
    %(
      SELECT * FROM DRIVERS WHERE latitude > #{p3_x.to_s} AND latitude <  #{p1_x.to_s} AND
      longitude < #{p2_y.to_s} AND longitude > #{p4_y.to_s} 
    )
  end
end
