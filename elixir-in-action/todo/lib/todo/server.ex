defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start_link(Todo.Server, nil)
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
  def init(_) do
    {:ok, Todo.List.new()}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_state) do
    {:reply, Todo.List.entries(todo_state, date), todo_state}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todo_state) do
    {:noreply, Todo.List.add_entry(todo_state, entry)}
  end

  def handle_cast({:update_entry, entry_id, update_fun}, todo_state) do
    {:noreply, Todo.List.update_entry(todo_state, entry_id, update_fun)}
  end

  def handle_cast({:delete_entry, entry_id}, todo_state) do
    {:noreply, Todo.List.delete_entry(todo_state, entry_id)}
  end
end
