defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList do
  def new(), do: %{}

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

# todo_list = TodoList.new() |>
# TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentista"}) |>
# TodoList.add_entry(%{date: ~D[2018-12-20], title: "Movie"}) |>
# TodoList.add_entry(%{date: ~D[2018-12-19], title: "Shopping"})
