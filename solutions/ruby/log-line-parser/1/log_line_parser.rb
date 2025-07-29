class LogLineParser
  def initialize(line)
    @line = line
  end

  def message    
    @line.slice(@line.index(':') + 2 .. -1).strip
  end

  def log_level
    @line.slice(@line.index('[') + 1 .. @line.index(']') - 1).downcase
  end

  def reformat
    message.concat(' (', log_level, ')')
  end
end
