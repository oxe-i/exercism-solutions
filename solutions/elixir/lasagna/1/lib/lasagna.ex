defmodule Lasagna do
  def expected_minutes_in_oven do
      40
  end

  def remaining_minutes_in_oven(time_in_oven) do
     expected_minutes_in_oven() - time_in_oven
  end

  def preparation_time_in_minutes(layers) do
     2 * layers
  end

  def total_time_in_minutes(layers, minutes_in_oven) do
     preparation_time_in_minutes(layers) + minutes_in_oven
  end

  def alarm do
     "Ding!"
  end
  # Please define the 'expected_minutes_in_oven/0' function

  # Please define the 'remaining_minutes_in_oven/1' function

  # Please define the 'preparation_time_in_minutes/1' function

  # Please define the 'total_time_in_minutes/2' function

  # Please define the 'alarm/0' function
end
