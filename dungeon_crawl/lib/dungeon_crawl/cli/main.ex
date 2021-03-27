defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("pressione ENTER para continuar...")
    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp crawl(%{hit_points: 0}, _) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("Infelizmente você está muito ferido para continuar caminhando.")
    Shell.info("Você caiu no chão sem forças para seguir.")
    Shell.info("fim de Jogo!")
  end

  defp crawl(character, rooms) do
    Shell.info("Você está seguindo para a próxima sala...")
    Shell.prompt("Pressione ENTER para continuar...")
    Shell.cmd("clear")

    Shell.info(DungeonCrawl.Character.current_stats(character))

    rooms
    |> Enum.random()
    |> DungeonCrawl.CLI.RoomActionChoice.start()
    |> trigger_action(character)
    |> handle_action_result
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}),
    do: Shell.info("A saída foi encontrada. Você venceu. Parabéns!")

  defp handle_action_result({character, _}), do: crawl(character, DungeonCrawl.Room.all())

  defp welcome_message do
    Shell.info("== Rastejando na Masmorra ==")
    Shell.info("Você acorda em uma masmorra cheia de monstros.")
    Shell.info("Você precisa sobreviver e encontrar a saída.")
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoise.start()
    %{hero | name: "Você"}
  end
end
