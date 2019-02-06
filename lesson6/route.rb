class Route

  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  protected

  def validate!
    raise "Starting and ending stations are the same" if @stations.first == @stations.last
  end

  def valid?
    validate!
    true
  rescue
    false
  end

end
