user_input = IO.gets "Qual seus pontos de habilidade:\n"

case Integer.parse(user_input) do
  :error -> IO.puts("Pontos de habilidade inválidos: #{user_input}")
  { ability_score, _ } ->
  ability_modifier = (ability_score - 10) / 2
  IO.puts "Sua habilidade modificada é #{ability_modifier}"
end
