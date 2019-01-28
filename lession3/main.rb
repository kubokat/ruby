load 'route.rb'
load 'station.rb'
load 'train.rb'

station1 = Station.new('1905 square')
station2 = Station.new('Geology')
station3 = Station.new('Mashinostrioteley')
station4 = Station.new('Dinamo')

route = Route.new(station1, station4)

route.add_station(station2)
route.add_station(station3)

route.stations.each {|station| puts "Station:  #{station.name}"}

train1 = Train.new(1, 'Cargo', 2)

train1.set_route(route)

puts train1.next_station

puts train1.route_prev_station.name

station2.trains.each {|train| puts "Train number: #{train.number} on #{station2.name} station"}

