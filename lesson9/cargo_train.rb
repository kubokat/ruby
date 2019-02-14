# Cargo train
class CargoTrain < Train

  validate :number, :presence
  validate :number, :format, TRAIN_FORMAT
  validate :speed, :type, Fixnum

  def add_wagon(wagon)
    return false if wagon.class != CargoWagon

    super
  end
end
