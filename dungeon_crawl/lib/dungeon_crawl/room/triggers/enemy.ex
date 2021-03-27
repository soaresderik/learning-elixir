defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())

    Shell.info(enemy.description)
    Shell.info("O #{enemy.name} quer lutar com você.")
    Shell.info("Você estava preparado e atacou primeiro.")
    {update_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)

    {update_char, :forward}
  end
end
