class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_trains
    @trains.each {|train| puts "Train  № #{train.number} type #{train.type}"}
  end

  def show_trains_by_type(type)
    count = 0
    @trains.each {|train| count += 1 if train.type == type}
    puts "Trains with type #{type} #{count} on station"
  end

  def send_train(train)
    @trains.delete(train)
  end
end
