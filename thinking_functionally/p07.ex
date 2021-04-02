defmodule StringList do
  def upcase([first | rest]), do: [String.upcase(first) | upcase(rest)]
  def upcase([]), do: []
end

# StringList.upcase(["o rato", "roeu", "a roupa", "do rei", "de roma"])
# Simplificado Enum.map(["o rato", "roeu", "a roupa", "do rei", "de roma"], &String.upcase/1)
