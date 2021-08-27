# Supervisor.start_link([Todo.Cache], strategy: :one_for_one)
# bobs_list = Todo.Cache.server_process("Bob's list")

# cache_pid = Process.whereis(Todo.Cache)
# Process.exit(cache_pid, :kill)

# Todo.System.start_link()


:erlang.system_info(:process_count)

Process.exit(Process.whereis(Todo.Cache), :kill)

for _ <- 1..4 do
  Process.exit(Process.whereis(Todo.Cache), :kill)
  Process.sleep(200)
end
