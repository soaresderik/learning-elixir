defmodule DungeonCrawl.CLI.HeroChoise do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start do
    Shell.cmd("clear")
    Shell.info("Começe escolhendo o seu herói:")

    DungeonCrawl.Heroes.all()
    |> ask_for_option
    |> confirm_hero()
  end

  defp confirm_hero(chosen_hero) do
    Shell.cmd("clear")
    Shell.info(chosen_hero.description)
    if Shell.yes?("Confirmar?"), do: chosen_hero, else: start()
  end
end
