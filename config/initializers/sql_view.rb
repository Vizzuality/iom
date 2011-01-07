require 'sql_view'

Dir[Rails.root.join("db/migrate/views/**/*.rb")].each {|f| require f}