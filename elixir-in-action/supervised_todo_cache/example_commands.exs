Supervisor.start_link([Todo.Cache], strategy: :one_for_one)
bobs_list = Todo.Cache.server_process("Bob's list")

cache_pid = Process.whereis(Todo.Cache)
Process.exit(cache_pid, :kill)

Todo.System.start_link()
