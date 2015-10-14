defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self, fn(_, send_to) -> spawn(Chain, :counter, [send_to]) end

    # start the count by sending
    send last, 0

    receive do
      final_answer when is_integer(final_answer) -> "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# Execute with
# $ elixir -r chain.exs -e "Chain.run(100)"

# More than Limit
# $ elixir --erl "+P 1_000_000" -r chain.exs -e "Chain.run(900_000)"
