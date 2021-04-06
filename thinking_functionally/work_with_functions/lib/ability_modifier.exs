user_input = IO.gets "Qual seus pontos de habilidade:\n"

result = case Integer.parse(user_input) do
  :error -> "Pontos de habilidade inválidos: #{user_input}"
  { ability_score, _ } when ability_score >= 0 ->
  ability_modifier = (ability_score - 10) / 2
  "Sua habilidade modificada é #{ability_modifier}"
end

IO.puts(result)
