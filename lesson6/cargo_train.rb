class CargoTrain < Train
  def add_wagon(wagon)
    return false if wagon.class != CargoWagon
    super
  end
end
