# Passenger Train class
class PassengerTrain < Train
  def add_wagon(wagon)
    return false if wagon.class != PassengerWagon

    super
  end
end
