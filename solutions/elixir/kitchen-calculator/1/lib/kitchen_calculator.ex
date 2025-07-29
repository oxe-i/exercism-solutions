defmodule KitchenCalculator do
  defp volume(:cup), do: 240
  defp volume(:fluid_ounce), do: 30
  defp volume(:teaspoon), do: 5
  defp volume(:tablespoon), do: 15
  defp volume(:milliliter), do: 1

  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    {:milliliter, get_volume(volume_pair) * (volume_pair |> elem(0) |> volume)}
  end

  def from_milliliter(volume_pair, unit) do
    {unit, get_volume(volume_pair) / volume(unit)}
  end

  def convert(volume_pair, unit) do
    {unit, volume_pair |> to_milliliter |> from_milliliter(unit) |> get_volume}
  end
end
