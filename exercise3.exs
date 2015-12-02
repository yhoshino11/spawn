defmodule Ex3 do
  import :timer, only: [sleep: 1]

  def start(sender) do
    send sender, {:ok, "Started"}
    exit(:boom)
  end

  def run do
    spawn_link(Ex3, :start, [self])
    sleep 500
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
    end
  end
end

Ex3.run
