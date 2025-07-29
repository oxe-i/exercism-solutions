module Port
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city.slice(0 .. 3).upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    case ship_identifier.to_s.slice(0 .. 2)
    when 'OIL', 'GAS'
      return :A
    end
    return :B
  end
end
