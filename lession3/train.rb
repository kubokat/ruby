class Train

  attr_accessor :wagon, :speed
  attr_reader :number, :type

  def initialize(number, type = 'Cargo', wagon = 1)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
  end

  def remove_wagon
    if self.wagon <= 0
      puts "Couch = #{self.wagon}"
    elsif self.speed > 0
      puts "Speed #{self.speed} the wagon cannot be removed"
    else
      self.wagon = self.wagon - 1 if self.wagon > 0
      puts "One wagon remove current couch = #{self.wagon}"
    end
  end

  def add_wagon
    if self.speed > 0
      puts "Speed #{self.speed} the wagon cannot be add"
    else
      self.wagon = self.wagon + 1
      puts "One wagon add current couch = #{self.wagon}"
    end
  end

  def set_station
    if @route.stations[@current_station] != nil
      @route.stations[@current_station].add_train(self)
      puts @route.stations[@current_station].name
    else
      puts "Undefined station"
    end
  end

  def set_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def next_station
    @route.stations[@current_station].send_train(self)
    @current_station += 1
    set_station
  end

  def prev_station
    @route.stations[@current_station].send_train(self)
    @current_station -= 1
    set_station
  end
end
