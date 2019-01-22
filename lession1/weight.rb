#Идеальный вес

puts 'Как вас зовут?'
name = gets.chomp
puts 'Как у вас рост'
full_height = gets

full_height = full_height.to_i - 110

if (full_height > 0)
	puts "#{name} ваш идельный вес #{full_height.to_s}"
else
	puts "Ваш вес уже оптимальный"
end
