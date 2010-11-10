User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'

spain = Country.create :name => 'Spain', :code => 'ES'
usa   = Country.create :name => 'United States', :code => 'US'

valencia = Region.create :name => 'Valencia', :country => spain
madrid   = Region.create :name => 'Madrid',   :country => spain

baltimore = Region.create :name => 'Baltimore', :country => usa
alabama   = Region.create :name => 'Alabama',   :country => usa