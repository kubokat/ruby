class PassengerTrain < Train

  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    return false if wagon.class != PassengerWagon

    super
  end
end
