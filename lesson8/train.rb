class Train
  include Manufacturer
  include InstanceCounter

  TRAIN_FORMAT = /^[a-z0-9]{3}(\-[a-z0-9]{2})?$/

  attr_accessor :wagons, :speed
  attr_reader :number, :route

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @station_index = 0
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

  def route(route)
    @route = route
    current_station.add_train(self)
  end

  def move_forward
    if @route.stations[@station_index + 1]
      current_station.send_train(self)
      @station_index += 1
      set_station
    end
  end

  def move_back
    if @station_index > 0
      current_station.send_train(self)
      @station_index -= 1
      set_station
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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

  def validate!
    raise "Train number can't be nil" if number.nil?
    raise 'Train number has invalid format' if number !~ TRAIN_FORMAT
  end
end
