#Найти порядковый номер даты, начиная отсчет с начала года.

puts "Введите день"
day = gets.to_i
puts "Введите месяц"
month = gets.to_i
puts "Введите год"
year = gets.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

month_days[1] = 29 if (year % 4 == 0) || (year % 4 == 0 && year % 100 != 0)

res = day + days.take(month - 1).sum

puts res
