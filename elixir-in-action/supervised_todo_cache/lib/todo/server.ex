defmodule Todo.Server do
  use GenServer

  def start_link(list_name) do
    IO.puts("Starting database server.")
    GenServer.start_link(Todo.Server, list_name)
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def update_entry(pid, entry_id, update_fun) do
    GenServer.cast(pid, {:update_entry, entry_id, update_fun})
  end

  def delete_entry(pid, entry_id) do
    GenServer.cast(pid, {:delete_entry, entry_id})
  end

  @impl GenServer
  def init(list_name) do
    {:ok, {list_name, Todo.Database.get(list_name) || Todo.List.new()}}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, {_, todo_state}) do
    {:reply, Todo.List.entries(todo_state, date), todo_state}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, {name, todo_state}) do
    new_entry = Todo.List.add_entry(todo_state, entry)
    Todo.Database.store(name, new_entry)
    {:noreply, {name, new_entry}}
  end

  def handle_cast({:update_entry, entry_id, update_fun}, {_, todo_state}) do
    {:noreply, Todo.List.update_entry(todo_state, entry_id, update_fun)}
  end

  def handle_cast({:delete_entry, entry_id}, {_, todo_state}) do
    {:noreply, Todo.List.delete_entry(todo_state, entry_id)}
  end
end
