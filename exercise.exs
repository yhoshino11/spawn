defmodule SendToken do
  def echo do
    receive do
      {sender, token} ->
        send sender, {:ok, token}
      echo
    end
  end
end

defmodule Sender do
  def emit(sender, name) do
    send spawn(SendToken, :echo, []), {sender, name}
    receive do
      {:ok, result} ->
        IO.puts result
    after 500 ->
      IO.puts "Gameover!"
    end
  end
end

defmodule Main do
  def exec(names), do: names |> Enum.map(&(Sender.emit(self, &1)))
end

["fred", "betty"] |> Main.exec
