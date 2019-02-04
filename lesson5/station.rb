class Station

  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
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
    @trains.select {|train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end
