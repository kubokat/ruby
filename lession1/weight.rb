#Идеальный вес

puts 'Как вас зовут?'
name = gets.chomp
puts 'Как у вас рост'
fullHeight = gets

fullHeight = fullHeight.to_i - 110

if (fullHeight > 0)
	puts "#{name} ваш идельный вес #{fullHeight.to_s}"
else 
	puts "Ваш вес уже оптимальный"
end	