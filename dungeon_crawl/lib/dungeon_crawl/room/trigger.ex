defmodule DungeonCrawl.Room.Trigger do
  alias DungeonCrawl.Character
  alias DungeonCrawl.Room.Action

  @callback run(Character.type, Action.t) :: {Character.t, atom}
end
