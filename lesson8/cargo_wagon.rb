# Cargo wagon class
class CargoWagon < Wagon
  attr_accessor :volume
  attr_reader :used_volume

  def initialize(volume)
    @name = 'Cargo wagon'
    @volume = volume
    @used_volume = 0
  end

  def take_volume(volume)
    if self.volume - volume > 0
      @used_volume += volume
    else
      @used_volume = self.volume
    end
  end

  def free
    volume - used_volume
  end
end
