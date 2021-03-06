defmodule TodoList do
  defstruct auto_id: 0, entries: %{}

  def new(), do: %__MODULE__{}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %__MODULE__{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end

# todo_list = TodoList.new() |>
# TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentista"}) |>
# TodoList.add_entry(%{date: ~D[2018-12-20], title: "Movie"}) |>
# TodoList.add_entry(%{date: ~D[2018-12-19], title: "Shopping"})
