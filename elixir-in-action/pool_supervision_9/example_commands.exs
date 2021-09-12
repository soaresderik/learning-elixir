Todo.System.start_link()

[{worker_pid, _}] =
  Registry.lookup(
    Todo.ProcessRegistry,
    {Todo.DatabaseWorker, 2}
  )

Process.exit(worker_pid, :kill)
