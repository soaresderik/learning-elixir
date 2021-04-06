{age, _} = Integer.parse(IO.gets("Digite a idade:\n"))

result = cond do
  age < 13 -> "Criança"
  age <= 18 -> "Adolescente"
  age > 18 -> "Adulto"
end

IO.puts "Resultado: #{result}"
