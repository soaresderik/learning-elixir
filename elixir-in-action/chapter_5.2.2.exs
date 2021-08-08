# Enviando mensagem para o PID atual
send(self(), "Uma mensagem")

# Recebendo mensagem
receive do
  message -> IO.puts(message)
end

# Enviando mensagem utilizando pattern matching
send(self(), {:message, 1})

# Recebendo e verificando padrão enviado através de pattern matching
receive do
  {:message, id} ->
    IO.puts("Messagem recebida #{id}")
end

# Setando mensagem default caso nenhuma mensagem seja enviada em um determinado tempo
receive do
  message -> IO.puts(message)
after
  2000 -> IO.puts("Nenhuma mensagem recebida")
end

send(self(), {:message, 5})

receive_result =
  receive do
    {:message, x} ->
      x * 2
  end

IO.inspect(receive_result)

# -- Envio de mensagem e Recebimento de resposta  --

run_query = fn query ->
  Process.sleep(2000)
  "#{query} result"
end

async_query = fn query ->
  caller = self()

  spawn(fn ->
    send(caller, {:query_results, run_query.(query)})
  end)
end

Enum.each(1..5, &async_query.("query #{&1}"))

get_result = fn ->
  receive do
    {:query_results, result} ->
      result
  end
end

results = Enum.map(1..5, fn _ -> get_result.() end)

1..5
|> Enum.map(&async_query.("query #{&1}"))
|> Enum.map(fn _ -> get_result.() end)
