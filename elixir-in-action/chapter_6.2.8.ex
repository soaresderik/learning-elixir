defmodule TodoServer do
  use GenServer

  def start do
    GenServer.start_link(TodoServer, nil)
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
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_state) do
    {:reply, TodoList.entries(todo_state, date), todo_state}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todo_state) do
    {:noreply, TodoList.add_entry(todo_state, entry)}
  end

  def handle_cast({:update_entry, entry_id, update_fun}, todo_state) do
    {:noreply, TodoList.update_entry(todo_state, entry_id, update_fun)}
  end

  def handle_cast({:delete_entry, entry_id}, todo_state) do
    {:noreply, TodoList.delete_entry(todo_state, entry_id)}
  end
end

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

# {:ok, pid} = TodoServer.start()
# TodoServer.add_entry(pid, %{date: ~D[2018-12-19], title: "Dentista"})
# TodoServer.add_entry(pid, %{date: ~D[2018-12-20], title: "Shopping"})
# TodoServer.add_entry(pid, %{date: ~D[2018-12-19], title: "Filmes"})

# TodoServer.update_entry(pid, 1, &Map.put(&1, :date, ~D[2018-12-19]))
# TodoServer.delete_entry(pid, 1)

# TodoServer.entries(pid, ~D[2018-12-19])
