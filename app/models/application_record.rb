class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
  load "#{Rails.root}/db/schema.rb"
end
