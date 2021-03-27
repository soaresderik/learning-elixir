defmodule DungeonCrawl.Enemies do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "Ogro",
        description: "Uma criatura alta. Grandes músculos. Zangado e faminto",
        hit_points: 12,
        max_hit_points: 12,
        damage_range: 3..5,
        attack_description: "um martelo"
      },
      %Character{
        name: "Minato",
        description: "Criatura demoniaca e verde. Usa uma armadura e um machado",
        hit_points: 8,
        max_hit_points: 8,
        damage_range: 2..4,
        attack_description: "um machado"
      },
      %Character{
        name: "Gnomo",
        description: "Criatura verde e pequena. Usa roupas sujas e uma adaga.",
        hit_points: 4,
        max_hit_points: 4,
        damage_range: 1..2,
        attack_description: "uma adaga"
      }
    ]
end
