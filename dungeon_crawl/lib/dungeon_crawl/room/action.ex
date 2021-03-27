defmodule DungeonCrawl.Room.Action do
  alias DungeonCrawl.Room.Action
  defstruct label: nil, id: nil

  @type t :: %Action{id: atom, label: String.t}

  def forward, do: %Action{id: :forward, label: "Siga em frente."}
  def rest, do: %Action{id: :rest, label: "Observe melhor e descance."}
  def search, do: %Action{id: :search, label: "Encontre a sala."}

  defimpl String.Chars do
    def to_string(action), do: action.label
  end
end
