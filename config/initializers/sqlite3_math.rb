ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
    alias_method :orig_initialize, :initialize
  
    # Extend database initialization to add our own functions
    def initialize(connection, logger = nil, pool = nil)
      orig_initialize(connection, logger, pool)
      connection.create_function "cos", 1 do |func, a|
        func.result = Math.cos(a)
      end
      connection.create_function "acos", 1 do |func, a|
          func.result = Math.acos(a)
      end
      connection.create_function "sin", 1 do |func, a|
          func.result = Math.sin(a)
      end
      connection.create_function "radians", 1 do |func, a|
          func.result = a * Math::PI / 180
      end
    end
  end