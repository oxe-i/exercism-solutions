stringify = (num) -> if num < 10 then "0#{num}" else "#{num}"
normalize = (hour, minute) -> (hour + (minute // 60)) % 24, minute % 60
  
class Clock
  new: (argument) =>
    { :hour, :minute } = argument
    @hour, @minute = normalize hour, minute

  __tostring: => "#{stringify @hour}:#{stringify @minute}"
  add: (minutes) => @hour, @minute = normalize @hour, @minute + minutes
  subtract: (minutes) => @hour, @minute = normalize @hour, @minute - minutes
  equals: (a_clock) => @hour == a_clock.hour and @minute == a_clock.minute
