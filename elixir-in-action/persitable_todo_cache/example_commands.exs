# # --- part 1 ---

{:ok, cache} = Todo.Cache.start()

bob_list = Todo.Cache.server_process(cache, "bobs_list")
Todo.Server.add_entry(bob_list, %{date: ~D[2018-12-19], title: "Filme"})
Todo.Server.entries(bob_list, ~D[2018-12-19])
