#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('A' .. 'Z').to_a
vowels = ['A', 'E', 'I', 'O', 'U']
res = {}

alphabet.each_with_index do |v, i|
  if vowels.include?(v)
    res[v] = i + 1
  end
end

puts res
