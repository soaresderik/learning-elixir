defmodule TodoServer do
  def start do
    ServerProcess.start(TodoServer)
  end

  def init do
    TodoList.new()
  end

  def entries(pid, date) do
    ServerProcess.call(pid, {:entries, date})
  end

  def add_entry(pid, entry) do
    ServerProcess.call(pid, {:add_entry, entry})
  end

  def update_entry(pid, entry_id, update_fun) do
    ServerProcess.call(pid, {:update_entry, entry_id, update_fun})
  end

  def delete_entry(pid, entry_id) do
    ServerProcess.call(pid, {:delete_entry, entry_id})
  end

  def handle_call({:add_entry, entry}, todo_state) do
    {:ok, TodoList.add_entry(todo_state, entry)}
  end

  def handle_call({:update_entry, entry_id, update_fun}, todo_state) do
    {:ok, TodoList.update_entry(todo_state, entry_id, update_fun)}
  end

  def handle_call({:entries, date}, todo_state) do
    {TodoList.entries(todo_state, date), todo_state}
  end

  def handle_call({:delete_entry, entry_id}, todo_state) do
    {:ok, TodoList.delete_entry(todo_state, entry_id)}
  end
end

defmodule ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()
      loop(callback_module, initial_state)
    end)
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} ->
        response
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
  end

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} =
          callback_module.handle_call(
            request,
            current_state
          )

        send(caller, {:response, response})

        loop(callback_module, new_state)

      {:cast, request} ->
        new_state =
          callback_module.handle_cast(
            request,
            current_state
          )

        loop(callback_module, new_state)
    end
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

# pid = TodoServer.start()
# TodoServer.add_entry(pid, %{date: ~D[2018-12-19], title: "Dentista"})
# TodoServer.add_entry(pid, %{date: ~D[2018-12-20], title: "Shopping"})
# TodoServer.add_entry(pid, %{date: ~D[2018-12-19], title: "Filmes"})

# TodoServer.update_entry(pid, 1, &Map.put(&1, :date, ~D[2018-12-19]))
# TodoServer.delete_entry(pid, 1)

# TodoServer.entries(pid, ~D[2018-12-19])
