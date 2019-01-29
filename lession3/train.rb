class Train

  attr_accessor :wagon, :speed
  attr_reader :number, :type

  def initialize(number, type = :cargo, wagon = 1)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
    @station_index = 0
  end

  def remove_wagon
    if wagon <= 0 || self.speed > 0
      false
    else
      self.wagon = wagon - 1 if wagon > 0
      wagon
    end
  end

  def add_wagon
    if self.speed > 0
      false
    else
      self.wagon += 1
    end
  end

  def set_station
    current_station.add_train(self)
    current_station
  end

  def set_route(route)
    @route = route
    current_station.add_train(self)
  end

  def move_forward
    unless @route.stations[@station_index + 1].nil?
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
