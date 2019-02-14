# Passenger Train class
class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, TRAIN_FORMAT
  validate :speed, :type, Fixnum

  def add_wagon(wagon)
    return false if wagon.class != PassengerWagon

    super
  end
end
