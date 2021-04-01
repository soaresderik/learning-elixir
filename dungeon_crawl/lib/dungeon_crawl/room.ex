defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers

  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all,
    do: [
      %Room{
        description: "Você consegue ver a luz do dia. Você encontrou a saída!",
        actions: [forward()],
        trigger: Triggers.Exit
      },
      %Room{
        description: "Um inimigo está bloqueando o seu caminho.",
        actions: [forward()],
        trigger: Triggers.Enemy
      },
      %Room{
        description: "Você encontrou um lugar tranquilo. Parece seguro para um descanso",
        actions: [forward(), rest(), search()],
        trigger: Enum.random([Triggers.Rest, Triggers.EnemyHidden])
      }
    ]
end
