user_input = IO.gets "Qual seus pontos de habilidade:\n"
{ ability_score, _ } = Integer.parse(user_input)
ability_modifier = (ability_score - 10) / 2
IO.puts "Sua habilidade modificada é #{ability_modifier}"
