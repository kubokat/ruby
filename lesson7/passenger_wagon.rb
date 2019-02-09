class PassengerWagon < Wagon

  attr_accessor :used_seats
  attr_reader :number_of_seats

  def initialize(number_of_seats)
    @name = 'Passenger wagon'
    @number_of_seats = number_of_seats
    @used_seats = 0
  end

  def take_seat
    self.used_seats += 1 if free > 0
  end

  def free
    number_of_seats - used_seats
  end

end
