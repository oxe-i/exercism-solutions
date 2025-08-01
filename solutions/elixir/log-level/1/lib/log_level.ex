defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level < 0 or level > 5 -> :unknown
      legacy? and (level === 0 or level === 5) -> :unknown
      level === 0 -> :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 -> :fatal
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label === :error or label === :fatal -> :ops
      label === :unknown and legacy? -> :dev1
      label === :unknown -> :dev2
      true -> false
    end      
  end
end
