class Menu
  def initialize
    @stations = []
    @trains = []
    @route = nil
    @wagons = []
  end

  def run
    loop do
      puts '1. Создать станцию'
      puts '2. Создать поезд'
      puts '3. Создать маршрут'
      puts '4. Добавить станцию к маршруту'
      puts '5. Убрать станцию из маршрута'
      puts '6. Назначить маршрут поезду'
      puts '7. Прицепить вагон к поезду'
      puts '8. Отцепить вагон от поезда'
      puts '9. Заполнить вагон'
      puts '10. Передвинуть поезд вперёд по маршруту'
      puts '11. Передвинуть поезд назад по маршруту'
      puts '12. Посмотреть список станций'
      puts '13. Посмотреть список поездов на станции'
      puts '14. Выход'

      @choise = gets.to_i

      break if choise == 14

      change_choice
    end
  end

  private

  ROUTE_NOT_FOUND = 'Нет маршрута'.freeze
  CHANGE_STATION = 'Выберете станцию'.freeze

  attr_accessor :choise

  def change_choice
    case choise
    when 1 then
      create_station
    when 2 then
      create_train
    when 3 then
      create_route
    when 4 then
      add_station_to_route
    when 5 then
      delete_station_from_route
    when 6 then
      set_route_to_train
    when 7 then
      add_wagon
    when 8 then
      remove_wagon
    when 9 then
      fill_wagon
    when 10 then
      move_forward
    when 11 then
      move_back
    when 12 then
      print_stations_list
    when 13 then
      print_trains_on_station
    else
      puts 'action not found'
    end
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def create_train
    puts 'Выберите тип поезда:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    choise = gets.to_i
    puts 'Номер поезда:'
    number = gets.chomp
    case choise
    when 1 then
      train = PassengerTrain.new(number)
    when 2 then
      train = CargoTrain.new(number)
    end

    @trains << train
    puts "Train type #{train.class} with number #{train.number} created"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    return 'Должно быть создано не менее двух станций' if @stations.size < 2

    print_stations_list

    puts 'Выберите начальную станцию:'
    first_station = gets.to_i
    puts 'Выберите конечную станцию:'
    last_station = gets.to_i

    if first_station != last_station
      @route = Route.new(@stations[first_station - 1],
                         @stations[last_station - 1])
    else
      create_route
    end
  end

  def add_station_to_route
    return puts 'Нет станций' if @stations.empty?
    return puts ROUTE_NOT_FOUND if @route.nil?

    station = @stations[chose_station - 1]
    @route.add_station(station)
  end

  def print_stations_list
    @stations.each_with_index do |station, index|
      puts "Cтанция: #{index + 1}  #{station.name}"
      station.train_list do |train|
        puts "  Train number: #{train.number},
                train type: #{train.class},
                numbers of wagons: #{train.wagons.length}
        "
        i = 1
        train.wagons_list do |wagon|
          wagon_list = "     Wagon number:#{i} , wagon type: #{wagon.class}"

          wagon_list += if wagon.class == PassengerWagon
                          ", free seats: #{wagon.free}, seats: #{wagon.number_of_seats}"
                        else
                          ", free value: #{wagon.free}, volume: #{wagon.volume}"
                        end
          i += 1
          puts wagon_list
        end
      end
    end
  end

  def chose_station
    print_stations_list
    puts CHANGE_STATION
    choise = gets.to_i
    choise <= @stations.size ? choise : chose_station
  end

  def delete_station_from_route
    return puts ROUTE_NOT_FOUND unless @route
    return puts 'В маршруте не может быть менее двух станций' if @route.stations.size == 2

    @route.stations.each_with_index do |station, index|
      puts "Cтанция #{index + 1} #{station.name}"
    end

    puts CHANGE_STATION
    choise = gets.to_i
    @route.delete_station(@stations[choise - 1]) if choise <= @route.stations.size
  end

  def set_route_to_train
    return ROUTE_NOT_FOUND unless @route

    train = chose_train
    train.set_route(@route)
  end

  def chose_train
    return 'Нет поездов' unless @trains.any?

    @trains.each_with_index { |train, index| puts "#{index + 1}  #{train.number}" }

    puts 'Выберите поезд:'
    choise = gets.to_i
    choise <= @trains.size ? @trains[choise - 1] : chose_train
  end

  def add_wagon
    train = chose_train
    if train.class == PassengerTrain
      puts 'Введите количество мест в вагоне'
    else
      puts 'Введите объем вагона'
    end

    choise = gets.to_i

    wagon = train.class == PassengerTrain ? PassengerWagon.new(choise) : CargoWagon.new(choise)
    train.add_wagon(wagon)
  end

  def fill_wagon
    train = chose_train

    if train.wagons.any?
      puts 'Выберете вагон'
      i = 1
      train.wagons_list do |wagon|
        if wagon.class == PassengerWagon
          puts "#{i} seats: #{wagon.number_of_seats} seats free: #{wagon.free}"
        else
          puts "#{i} volume: #{wagon.volume} seats free: #{wagon.free}"
        end
        i += 1
      end

      choise = gets.to_i
      wagon = train.wagons[choise - 1]

      if wagon.class == CargoWagon
        puts 'Введите объем груза'
        choise = gets.to_i
        wagon.take_volume(choise)
      else
        wagon.take_seat
      end

    end
  end

  def remove_wagon
    train = chose_train
    train.remove_wagon
  end

  def print_trains_on_station
    station = @stations[chose_station - 1]
    station.trains.each do |train|
      puts "Поезд: #{train.number} #{train.class}"
      train.wagons_list do |wagon|
        puts wagon.class
      end
    end
  end

  def move_forward
    train = chose_train
    return ROUTE_NOT_FOUND unless train.route

    train.move_forward
  end

  def move_back
    train = chose_train
    return ROUTE_NOT_FOUND unless train.route

    train.move_back
  end
end
