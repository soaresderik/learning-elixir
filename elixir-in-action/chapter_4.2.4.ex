defmodule TodoList do
  defstruct auto_id: 0, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %__MODULE__{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %__MODULE__{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def update_entry(todo_list, entry_id, update_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = update_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %__MODULE__{todo_list | entries: new_entries}
    end
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def delete_entry(todo_list, entry_id) do
    %__MODULE__{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end

# entries = [
#   %{data: ~D[2018-12-19], title: "Dentista"},
#   %{data: ~D[2018-12-20], title: "Shopping"},
#   %{data: ~D[2018-12-19], title: "Filmes"},
# ]

# todo_list =
#   TodoList.new()  |>
#   TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentista"}) |>
#   TodoList.add_entry(%{date: ~D[2018-12-20], title: "Movie"}) |>
#   TodoList.add_entry(%{date: ~D[2018-12-19], title: "Shopping"}) |>
#   TodoList.delete_entry(1)

# TodoList.update_entry(todo_list, 1, &Map.put(&1, :date, ~D[2018-12-21]))

# #  Provocando erro
# TodoList.update_entry(todo_list, 1, fn _ -> %{id: 2, foo: "bar"} end)
