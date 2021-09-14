defmodule Todo.Server do
  use Agent, restart: :temporary

  def start_link(name) do
    Agent.start_link(
      fn ->
        IO.puts("Starting to-do server for #{name}")
        {name, Todo.Database.get(name) || Todo.List.new()}
      end,
      name: via_tuple(name)
    )
  end

  def entries(todo_server, date) do
    Agent.get(todo_server, fn {_, todo_list} ->
      Todo.List.entries(todo_list, date)
    end)
  end

  def add_entry(todo_server, entry) do
    Agent.cast(todo_server, fn {name, todo_list} ->
      new_list = Todo.List.add_entry(todo_list, entry)
      Todo.Database.store(name, new_list)
      {name, new_list}
    end)
  end

  def update_entry(todo_server, entry_id, update_fun) do
    Agent.cast(todo_server, fn {_, todo_list} ->
      Todo.List.update_entry(todo_list, entry_id, update_fun)
    end)
  end

  def delete_entry(todo_server, entry_id) do
    Agent.cast(todo_server, fn {_, todo_list} ->
      Todo.List.delete_entry(todo_list, entry_id)
    end)
  end

  defp via_tuple(name) do
    Todo.ProcessRegistry.via_tuple({__MODULE__, name})
  end
end
