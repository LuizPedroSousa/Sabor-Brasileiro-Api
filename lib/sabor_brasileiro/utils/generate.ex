defmodule SaborBrasileiro.Utils.Generate do
  @spec random_n_char_number_string(integer()) :: String.t()
  def random_n_char_number_string(n) do
    "~#{n}..0B"
    |> :io_lib.format([(10 |> :math.pow(n) |> round() |> :rand.uniform()) - 1])
    |> List.to_string()
  end
end
