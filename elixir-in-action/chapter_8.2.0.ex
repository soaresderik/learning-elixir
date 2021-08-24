spawn(fn ->
  spawn(fn ->
    Process.sleep(1000)
    IO.puts("Process 2 has finished")
  end)

  raise("An error has occurred")
end)

# 23:41:03.295 [error] Process #PID<0.133.0> raised an exception
# ** (RuntimeError) An error has occurred
#     (stdlib 3.15.2) erl_eval.erl:683: :erl_eval.do_apply/6
# Process 2 has finished

spawn(fn ->
  spawn_link(fn ->
    Process.sleep(1000)
    IO.puts("Process 2 has finished")
  end)

  raise("An error has occurred")
end)

# 23:49:29.114 [error] Process #PID<0.143.0> raised an exception
# ** (RuntimeError) An error has occurred
#     (stdlib 3.15.2) erl_eval.erl:683: :erl_eval.do_apply/6
# #PID<0.143.0>

spawn(fn ->
  Process.flag(:trap_exit, true)

  spawn_link(fn -> raise("Something went wrong.") end)

  receive do
    msg ->
      IO.inspect(msg)
  end
end)

# 23:55:44.065 [error] Process #PID<0.118.0> raised an exception
# ** (RuntimeError) Something went wrong.
#     (stdlib 3.15.2) erl_eval.erl:683: :erl_eval.do_apply/6
# {:EXIT, #PID<0.118.0>,
#  {%RuntimeError{message: "Something went wrong."},
#   [{:erl_eval, :do_apply, 6, [file: 'erl_eval.erl', line: 683]}]}}

target_pid =
  spawn(fn ->
    Process.sleep(1000)
  end)

Process.monitor(target_pid)

receive do
  msg -> IO.inspect(msg)
end
