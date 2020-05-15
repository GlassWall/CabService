module Calculator
  class DerivedPoints
    attr_reader :lat, :long, :range, :bearing
    def initialize(lat:, long:, range:, bearing:)
      @lat = lat
      @long = long
      @bearing = bearing
      @range = range
    end

    def calculate_derived_position
      earth_radius = 6371000

      latA = lat * (Math::PI / 180) 
      lonA = long * (Math::PI / 180)
      angular_distance = range / earth_radius
      trueCourse = bearing * (Math::PI / 180) 
      lat = Math.asin(Math.sin(latA) * Math.cos(angular_distance) + Math.cos(latA) * Math.sin(angular_distance) * Math.cos(trueCourse))

      dlon = Math.atan2(Math.sin(trueCourse) * Math.sin(angular_distance) * Math.cos(latA), Math.cos(angular_distance) - Math.sin(latA) * Math.sin(lat))

      lon = ((lonA + dlon + Math::PI) % (Math::PI * 2)) - Math::PI

      lat = (lat * 180) / Math::PI
      lon = (lon * 180) / Math::PI
      return lat, lon
    end
  end
end
