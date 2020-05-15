require 'active_record/connection_adapters/sqlite3_adapter'

class ActiveRecord::ConnectionAdapters::SQLite3Adapter
    def initialize
        byebug
        db.create_function "cos", 1 do |func, a|
            func.result = Math.cos(a)
        end
        db.create_function "acos", 1 do |func, a|
            func.result = Math.acos(a)
        end
        db.create_function "sin", 1 do |func, a|
            func.result = Math.sin(a)
        end
        db.create_function "radians", 1 do |func, a|
            func.result = a * Math::PI / 180
        end
    
  end
end