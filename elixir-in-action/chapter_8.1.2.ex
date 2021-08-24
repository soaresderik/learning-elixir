try_helper = fn fun ->
  try do
    fun.()
    IO.puts("No Error.")
  catch
    type, value ->
      IO.puts("Error\n #{inspect(type)}\n #{inspect(value)}")
  end
end

try_helper.(fn -> raise("Algo está errado.") end)
# Error
#  :error
#  %RuntimeError{message: "Algo está errado."}

try_helper.(fn -> throw("Throw value") end)
# Error
#  :throw
#  "Throw value"
