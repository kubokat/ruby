# Route class
class Route
  include InstanceCounter
  extend Accessors

  VALIDATE_MESSAGE = 'Start and end stations are the same'.freeze

  attr_accessor_with_history :stations

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

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise VALIDATE_MESSAGE if @stations.first == @stations.last
  end
end
