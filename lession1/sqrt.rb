#Квадратное уравнение

args = {}

['a', 'b', 'c'].each do |ch|
  puts "Введите аргумент #{ch}"
  args[ch] = gets.to_f
end

d = args['b'] * args['b'] - 4 * args['a'] * args['c']

if d < 0
	puts "Корней нет, d = #{d}"
elsif d > 0
	x1 = (-args['b'] - Math.sqrt(d)) / (2 * args['a'])
	x2 = (-args['b'] + Math.sqrt(d)) / (2 * args['a'])

	puts "x1 = #{x1}, x2 = #{x2}, d = #{d}"
elsif d == 0
	x = -args['b'] / (2 * args['a'])
	puts "x = #{x}, d = #{d}"	
end