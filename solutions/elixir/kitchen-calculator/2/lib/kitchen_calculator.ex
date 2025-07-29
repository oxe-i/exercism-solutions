defmodule KitchenCalculator do
  defp volume_per_unit(:cup), do: 240
  defp volume_per_unit(:fluid_ounce), do: 30
  defp volume_per_unit(:teaspoon), do: 5
  defp volume_per_unit(:tablespoon), do: 15
  defp volume_per_unit(:milliliter), do: 1

  def get_volume({unit, volume}), do: volume

  def to_milliliter({unit, volume}) do
    {:milliliter, volume * (unit |> volume_per_unit)}
  end

  def from_milliliter({:milliliter, volume}, unit) do
    {unit, volume / (unit |> volume_per_unit)}
  end

  def convert(volume_pair, unit) do
    {unit, volume_pair |> to_milliliter |> from_milliliter(unit) |> get_volume}
  end
end
