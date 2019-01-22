#Прямоугольный треугольник

sides = [];

for i in 0..2
  puts 'Введите сторону'
  sides[i] = gets.to_f ** 2
end

sides = sides.uniq.sort
max = sides.max

if sides.length == 1
  puts 'Треугольник равнобедренный и равносторонний, но не прямоугольный';
else
  if sides.length == 2
    puts 'Треугольник равнобедренный'
    condition = sides[0] + sides[0] == max
  else
    condition = sides[0] + sides[1] == max
  end

  if condition
    puts 'Треугольник прямоугольный'
  else
    puts 'Треугольник не прямоугольный'
  end
end
