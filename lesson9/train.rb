# Train class
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  TRAIN_FORMAT = /^[a-z0-9]{3}(\-[a-z0-9]{2})?$/.freeze

  attr_reader :number, :route

  attr_accessor_with_history :speed, :wagons

  validate :number, :presence
  validate :number, :format, TRAIN_FORMAT
  validate :speed, :type, Fixnum

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @station_index = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def remove_wagon
    if wagons.empty? || speed > 0
      false
    else
      wagons.pop
    end
  end

  def add_wagon(wagon)
    if speed > 0
      false
    else
      wagons << wagon
    end
  end

  def add_route(route)
    @route = route
    current_station.add_train(self)
  end

  def move_forward
    return unless @route.stations[@station_index + 1]

    current_station.send_train(self)
    @station_index += 1
    set_station
  end

  def move_back
    return unless @station_index > 0

    current_station.send_train(self)
    @station_index -= 1
    set_station
  end

  def wagons_list
    @wagons.each_with_index { |wagon, _index| yield wagon }
  end

  protected

  # Methods used only child classes

  attr_writer :station_index

  def set_station
    current_station.add_train(self)
    current_station
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def current_station
    @route.stations[@station_index]
  end

  def prev_station
    @route.stations[@station_index - 1] if @station_index > 0
  end
end
