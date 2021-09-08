# Supervisor.start_link([Todo.Cache], strategy: :one_for_one)
# bobs_list = Todo.Cache.server_process("Bob's list")

# cache_pid = Process.whereis(Todo.Cache)
# Process.exit(cache_pid, :kill)

# Todo.System.start_link()


:erlang.system_info(:process_count)

Process.exit(Process.whereis(Todo.Cache), :kill)
Process.exit(Process.whereis(Todo.Database), :kill)

for _ <- 1..4 do
  Process.exit(Process.whereis(Todo.Cache), :kill)
  Process.sleep(200)
end

# ----

Registry.start_link(name: :my_registry, keys: :unique)

spawn(fn ->
  Registry.register(:my_registry, {:database_worker, 1}, nil)
  receive do
    msg  ->
      IO.puts("got message #{inspect(msg)}")
  end
end)

[{db_worker_pid, _value}] =
  Registry.lookup(:my_registry, {:database_worker, 1})

send(db_worker_pid, :some_message)
