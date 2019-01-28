class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_trains_by_type(type)
    count = 0
    @trains.each {|train| count += 1 if train.type == type}
    count
  end

  def send_train(train)
    @trains.delete(train)
  end
end
