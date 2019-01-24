#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('A' .. 'Z').to_a
vowels = ['A', 'E', 'I', 'O', 'U']
res = {}

alphabet.each_with_index do |v, i|
  res[v] = i + 1 if vowels.include?(v)
end

puts res
