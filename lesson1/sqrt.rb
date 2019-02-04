#Квадратное уравнение

args = {}

['a', 'b', 'c'].each do |ch|
  puts "Введите аргумент #{ch}"
  args[ch] = gets.to_f
end

a, b, c = args['a'], args['b'], args['c']

d = b * b - 4 * a * c

if d < 0
	puts "Корней нет, d = #{d}"
elsif d > 0
	sqr_d = Math.sqrt(d)
	
	x1 = (-b - sqr_d) / (2 * a)
	x2 = (-b + sqr_d) / (2 * a)
	
	puts "x1 = #{x1}, x2 = #{x2}, d = #{d}"
elsif d == 0
	x = -b / (2 * a)
	puts "x = #{x}, d = #{d}"
end
