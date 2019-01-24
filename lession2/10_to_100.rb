#Заполнить массив числами от 10 до 100 с шагом 5

counter = 5
arr = []

while counter < 100
  counter += 5
  arr << counter
end

puts arr
