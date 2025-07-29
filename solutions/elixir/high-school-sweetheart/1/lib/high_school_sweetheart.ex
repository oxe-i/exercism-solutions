defmodule HighSchoolSweetheart do
  import String
  import Enum

  def first_letter(name), do: name |> trim_leading |> String.at(0)

  def initial(name), do: name |> first_letter |> upcase |> Kernel.<>(".")

  def initials(full_name), do: full_name |> split |> map(&(&1 |> initial)) |> join(" ")

  def pair(full_name1, full_name2) do
     """          
          ******       ******
        **      **   **      **
      **         ** **         **
     **            *            **
     **                         **
     """
<> "**     #{initials(full_name1)}  +  #{initials(full_name2)}     **\n" <>
     """
      **                       **
        **                   **
          **               **
            **           **
              **       **
                **   **
                  ***
                   *
     """
  end
end
