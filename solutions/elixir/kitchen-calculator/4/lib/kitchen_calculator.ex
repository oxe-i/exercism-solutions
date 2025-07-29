defmodule KitchenCalculator do
  defp volume_per_unit(:cup), do: 240
  defp volume_per_unit(:fluid_ounce), do: 30
  defp volume_per_unit(:teaspoon), do: 5
  defp volume_per_unit(:tablespoon), do: 15
  defp volume_per_unit(:milliliter), do: 1

  def get_volume({_, volume}), do: volume

  def to_milliliter({unit, volume}) do
    milliliters_per_unit = volume_per_unit(unit)
    {:milliliter, volume * milliliters_per_unit}
  end

  def from_milliliter({:milliliter, volume}, unit) do 
    milliliters_per_unit = volume_per_unit(unit)
    {unit, volume / milliliters_per_unit}
  end

  def convert(volume_pair, unit) do
    volume_in_milliliters = to_milliliter(volume_pair)
    from_milliliter(volume_in_milliliters, unit)
  end
end
