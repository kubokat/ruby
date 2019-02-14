# Menu class
class Menu
  ROUTE_NOT_FOUND = 'Нет маршрута'.freeze
  CHANGE_STATION = 'Выберете станцию'.freeze

  @@menu_items = ['Создать станцию', 'Создать поезд', 'Создать маршрут',
                  'Добавить станцию к маршруту', 'Убрать станцию из маршрута',
                  'Назначить маршрут поезду', 'Прицепить вагон к поезду',
                  'Отцепить вагон от поезда', 'Заполнить вагон',
                  'Передвинуть поезд вперёд по маршруту',
                  'Передвинуть поезд назад по маршруту',
                  'Посмотреть список станций',
                  'Посмотреть список поездов на станции', 'Выход']

  @@methods = %w[create_station create_train create_route add_station_to_route
                 delete_station_from_route set_route_to_train add_wagon remove_wagon
                 fill_wagon move_forward move_back print_stations_list print_trains_on_station]

  def initialize
    @stations = []
    @trains = []
    @route = nil
    @wagons = []
  end

  def run
    loop do
      begin
        @@menu_items.each_with_index do |item, index|
          puts "#{index + 1}. #{item}"
        end

        @choise = gets.to_i

        break if choise == 14

        change_choice
      rescue RuntimeError => e
        puts e.message
      end
    end
  end

  private

  attr_accessor :choise

  def change_choice
    send(@@methods[choise - 1]) if @@methods[choise - 1]
  end

  def create_station
    name = question('Введите название станции:', 'str')
    station = Station.new(name)
    @stations << station
  end

  def create_train
    choise = question(['Выберите тип поезда:', '1. Пассажирский', '2. Грузовой'])
    number = question('Номер поезда:', 'str')

    train = choise == 1 ? PassengerTrain.new(number) : CargoTrain.new(number)

    @trains << train
    puts "Train type #{train.class} with number #{train.number} created"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    return 'Должно быть создано не менее двух станций' if @stations.size < 2

    print_stations_list
    first_station = question('Выберите начальную станцию:')
    last_station = question('Выберите конечную станцию:')

    if first_station != last_station
      @route = Route.new(@stations[first_station - 1], @stations[last_station - 1])
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
        puts "Train number: #{train.number},
              train type: #{train.class},
              numbers of wagons: #{train.wagons.length}"
        show_wagons_list(train)
      end
    end
  end

  def chose_station
    print_stations_list
    choise = question(CHANGE_STATION)
    choise <= @stations.size ? choise : chose_station
  end

  def show_wagons_list(train)
    i = 1
    train.wagons_list do |wagon|
      wagon_list = "Wagon number:#{i} , wagon type: #{wagon.class}"
      wagon_list += if wagon.class == PassengerWagon
                      ", free seats: #{wagon.free}, seats: #{wagon.number_of_seats}"
                    else
                      ", free value: #{wagon.free}, volume: #{wagon.volume}"
                    end
      i += 1
      puts wagon_list
    end
  end

  def delete_station_from_route
    return puts ROUTE_NOT_FOUND unless @route

    return puts 'В маршруте не может быть менее двух станций' if @route.stations.size == 2

    print_stations_list

    choise = question(CHANGE_STATION)

    @route.delete_station(@stations[choise - 1]) if choise <= @route.stations.size
  end

  def set_route_to_train
    return ROUTE_NOT_FOUND unless @route

    train = chose_train
    train.add_route(@route)
  end

  def chose_train
    return 'Нет поездов' unless @trains.any?

    @trains.each_with_index do |train, index|
      puts "#{index + 1}  #{train.number}"
    end

    choise = question('Выберите поезд:')
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

      show_wagons_list(train)

      choise = question('Выберете вагон')
      wagon = train.wagons[choise - 1]

      if wagon.class == CargoWagon
        choise = question('Введите объем груза')
        wagon.take_volume(choise)
      else
        wagon.take_seat
      end
    else
      false
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
      show_wagons_list(train)
    end
  end

  def question(question, type = 'int')
    puts question

    if type == 'str'
      gets.chomp
    else
      gets.to_i
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
