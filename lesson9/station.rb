# Station class
class Station
  include InstanceCounter
  include Validation
  extend Accessors

  STATION_FORMAT = /[a-z]/i.freeze

  attr_accessor_with_history :name, :trains

  validate :name, :presence
  validate :name, :format, STATION_FORMAT

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @@stations << name
    @trains = []
    register_instance
  end

  def self.all
    @@stations
  end

  def add_train(train)
    @trains << train
  end

  def show_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def train_list
    @trains.each { |train| yield train }
  end

  private

  def validate!
    raise "Station name can't be nil" if name.nil?
    raise 'Name > 3 and < 255 symbols' if name.length < 3 || name.length > 255
    raise 'Station name has invalid format' if name !~ STATION_FORMAT
  end
end
