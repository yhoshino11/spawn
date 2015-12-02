defmodule SendToken do
  def echo do
    receive do
      {sender, token} ->
        send sender, {:ok, token}
      echo
    end
  end
end

defmodule Main do
  def exec(names), do: names |> Enum.map(&(emit(&1)))

  def emit(name) do
    send spawn(SendToken, :echo, []), {self, name}
    receive do
      {:ok, result} ->
        IO.puts "#{inspect result}"
    after 500 ->
      IO.puts "Timeout!"
    end
  end
end

["fred", "betty"] |> Main.exec
