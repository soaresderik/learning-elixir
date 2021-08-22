# # --- part 1 ---

# {:ok, todo_server} = Todo.Server.start()
# Todo.Server.add_entry(todo_server, %{date: ~D[2018-12-19], title: "Dentista"})
# Todo.Server.entries(todo_server, ~D[2018-12-19])


# # --- part 2 ---

# {:ok, cache} = Todo.Cache.start()
# default = Todo.Cache.server_process(cache, "Lista Padrão")
# andre = Todo.Cache.server_process(cache, "André lista")

# Todo.Server.add_entry(andre, %{date: ~D[2018-12-19], title: "Dentista"})
# Todo.Server.add_entry(default, %{date: ~D[2018-12-19], title: "Filme"})

# Todo.Server.entries(andre, ~D[2018-12-19])
# Todo.Server.entries(default, ~D[2018-12-19])

# :erlang.system_info(:process_count)

# Enum.each(
#   1..100_000,
#   fn x ->
#     Todo.Cache.server_process(cache, "Todo List: #{x}")
#   end
# )

# :erlang.system_info(:process_count)
