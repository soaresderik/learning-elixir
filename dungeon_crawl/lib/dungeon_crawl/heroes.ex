defmodule DungeonCrawl.Heroes do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "Cavaleiro",
        description: "Cavaleiro tem uma defesa forte e um dano consistente.",
        hit_points: 18,
        max_hit_points: 18,
        damage_range: 4..5,
        attack_description: "uma espada"
      },
      %Character{
        name: "Mago",
        description: "Mago tem um forte ataque, mas baixo hp.",
        hit_points: 8,
        max_hit_points: 8,
        damage_range: 6..10,
        attack_description: "uma bola de fogo"
      },
      %Character{
        name: "Pirata",
        description: "Pirata tem uma alta variação de dano no ataque.",
        hit_points: 12,
        max_hit_points: 12,
        damage_range: 1..12,
        attack_description: "uma armadilha"
      }
    ]
end
