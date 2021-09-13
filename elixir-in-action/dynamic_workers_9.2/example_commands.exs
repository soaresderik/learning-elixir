Todo.System.start_link()

bobs_list = Todo.Cache.server_process("Bob's list")
alices_list = Todo.Cache.server_process("Alice's list")

Process.exit(bobs_list, :kill)

bobs_list = Todo.Cache.server_process("Bob's list")
alices_list = Todo.Cache.server_process("Alice's list")
