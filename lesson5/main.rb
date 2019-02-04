require_relative 'instance_сounter.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'manufacturer.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'menu.rb'

#menu = Menu.new
#menu.run

train1 = Train.new('122')
train1.manufacturer = 'Santin'

puts train1.manufacturer

station1 = Station.new('1905 square')
station2 = Station.new('Geology')

puts '--'

puts Station.all

puts '--'

puts Train.find('122')

puts Station.instances
