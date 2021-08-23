# # --- part 1 ---

for index <- 0..5 do
  {:ok, worker} = Todo.Cache.start()

  current_list = Todo.Cache.server_process(worker, "#{index}_list")
  Todo.Server.add_entry(current_list, %{date: ~D[2018-12-19], title: "Filme"})
  Todo.Server.add_entry(current_list, %{date: ~D[2018-12-20], title: "Dentista"})
  Todo.Server.add_entry(current_list, %{date: ~D[2018-12-20], title: "Shopping"})
end

for index <- 0..5 do
  {:ok, worker} = Todo.Cache.start()

  current_list = Todo.Cache.server_process(worker, "#{index}_list")

  Todo.Server.entries(current_list, ~D[2018-12-20])
end
