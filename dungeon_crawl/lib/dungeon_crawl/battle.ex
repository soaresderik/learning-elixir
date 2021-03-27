defmodule DungeonCrawl.Battle do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  def fight(
        char_a = %{hit_points: hit_points_a},
        char_b = %{hit_points: hit_points_b}
      )
      when hit_points_a == 0 or hit_points_b == 0,
      do: {char_a, char_b}

  def fight(char_a, char_b) do
    char_b_after_damage = attack(char_a, char_b)
    char_a_after_damage = attack(char_b_after_damage, char_a)
    fight(char_a_after_damage, char_b_after_damage)
  end

  defp attack(%{hit_points: hit_points_a}, character_b) when hit_points_a == 0, do: character_b

  defp attack(char_a, char_b) do
    damage = Enum.random(char_a.damage_range)
    char_b_after_damage = Character.take_damage(char_b, damage)

    char_a
    |> attack_message(damage)
    |> Shell.info()

    char_b_after_damage
    |> receive_message(damage)
    |> Shell.info()

    char_b_after_damage
  end

  defp attack_message(character = %{name: "Você"}, damage) do
    "Você atacou com #{character.attack_description} e causou #{damage} de dano."
  end

  defp attack_message(character, damage) do
    "#{character.name} atacou com #{character.attack_description} e causou #{damage} de dano."
  end

  defp receive_message(character = %{name: "Você"}, damage) do
    "Você perdeu #{damage} de HP. HP Atual = #{character.hit_points}"
  end

  defp receive_message(character, damage) do
    "#{character.name} perdeu #{damage} de HP. HP Atual = #{character.hit_points}"
  end
end
