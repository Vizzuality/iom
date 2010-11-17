# Mandatory seeds

User.create :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'

# Env seeds (development)

spain = Country.create :name => 'Spain', :code => 'ES'
usa   = Country.create :name => 'United States', :code => 'US'

valencia = Region.create :name => 'Valencia', :country => spain
madrid   = Region.create :name => 'Madrid',   :country => spain

baltimore = Region.create :name => 'Baltimore', :country => usa
alabama   = Region.create :name => 'Alabama',   :country => usa

o1 = Organization.create :name => 'Org 1'

Cluster.create :name => 'c1'
Cluster.create :name => 'c2'
Cluster.create :name => 'c3'
Cluster.create :name => 'c4'

Sector.create :name => 's1'
Sector.create :name => 's2'
Sector.create :name => 's3'
Sector.create :name => 's4'

Tag.create :name => 'asia'
Tag.create :name => 'africa'
Tag.create :name => 'childhood'
Tag.create :name => 'earthquake'