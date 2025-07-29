=begin
Write your code for the 'Clock' exercise in this file. Make the tests in
`clock_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/clock` directory.
=end

class Clock
  attr_accessor:hour, :minute
  
  def initialize(hour: 0, minute: 0)
    @hour = hour
    @minute = minute

    format
  end

  private_class_method def format
    add_hour = @minute / 60
    @hour += add_hour
    @hour %= 24
    
    @minute %= 60    

    if @hour < 0
      @hour += 24
    end

    if @minute < 0
      @minute += 60
      @hour -= 1
    end
  end

  def +(obj)
    Clock.new(hour: self.hour + obj.hour, minute: self.minute + obj.minute)
  end

  def -(obj)
    Clock.new(hour: self.hour - obj.hour, minute: self.minute - obj.minute)
  end

  def ==(obj)
    (self.hour == obj.hour) and (self.minute == obj.minute)
  end

  def to_s
    string_hour = @hour.to_s
    string_minute = @minute.to_s

    if string_hour.length < 2
      string_hour = '0' + string_hour
    end

    if string_minute.length < 2
      string_minute = '0' + string_minute
    end

    string_hour + ':' + string_minute
  end
end
    