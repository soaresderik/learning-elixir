defmodule DungeonCrawl.Room.Triggers.Rest do
  alias DungeonCrawl.Room.Action
  alias Mix.Shell.IO, as: Shell

  @behaviour DungeonCrawl.Room.Trigger

  def run(character, %Action{id: :forward}) do
    Shell.info("Você está caminhando cautelosamente e já pode ver a próxima sala.")
    { character, :forward }
  end

  def run(character, %Action{id: :search}) do
    healing = Enum.random(0..5)

    Shell.info("Você está procurando por algo útil na sala.")

    if healing > 0 do
      Shell.info("Você encontrou um tesouro com uma poção dentro.")
      Shell.info("Você tomou a poção e restaurou #{healing} de HP.")

      {
        DungeonCrawl.Character.heal(character, healing),
        :forward
      }
    else
      Shell.info("Nada foi encontrado.")
      { character, :forward }
    end
  end

  def run(character, %Action{id: :rest}) do
      healing = 3

      Shell.info("Você está procurando um local confortável na sala para descançar.")
      Shell.info("Depois de um bom descanço você vai receber #{healing} HP")

    {
      DungeonCrawl.Character.heal(character, healing),
      :forward
    }
  end
end
