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
    validate!
    @name = name
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

  def train_list
    @trains.each { |train| yield train }
  end
end
