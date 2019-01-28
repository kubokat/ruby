class Train

  attr_accessor :wagon, :speed
  attr_reader :number, :type

  def initialize(number, type = :cargo, wagon = 1)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
    @current_station = 0
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
    @route.stations[@current_station].add_train(self)
    @route.stations[@current_station].name
  end

  def set_route(route)
    @route = route
    @route.stations[@current_station].add_train(self)
  end

  def next_station
    unless @route.stations[@current_station + 1].nil?
      @route.stations[@current_station].send_train(self)
      @current_station += 1
      set_station
    end
  end

  def prev_station
    if @current_station > 0
      @route.stations[@current_station].send_train(self)
      @current_station -= 1
      set_station
    end
  end

  def route_next_station
    @route.stations[@current_station + 1]
  end

  def route_current_station
    @route.stations[@current_station]
  end

  def route_prev_station
    @route.stations[@current_station - 1] if @current_station > 0
  end
end
