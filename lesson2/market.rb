#Сумма покупок

products = {}

loop do
  puts 'Введите название товара'
  name = gets.chomp

  break if name == 'стоп'

  puts 'Введите цену за единицу'
  price = gets.to_f

  puts 'Введите кол-во купленного товара'
  number = gets.to_i

  products[name] = {price: price, number: number}
end

sum = 0

products.each do |key, val|
  product_sum = val[:price] * val[:number]
  sum += product_sum
  puts "#{key} за #{val[:number]} #{product_sum}"
end

puts products
puts "Сумма #{sum}"
