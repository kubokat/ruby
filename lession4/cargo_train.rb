class CargoTrain < Train

  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    return false if wagon.class != CargoWagon

    super
  end
end
