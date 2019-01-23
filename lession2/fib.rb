#Заполнить массив числами фибоначчи до 100

fib = [0, 1]

loop do

  res = fib[-2] + fib[-1]

  if res >= 100
    break
  end

  fib << res
end

puts fib
