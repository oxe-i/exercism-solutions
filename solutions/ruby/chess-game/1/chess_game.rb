module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    RANKS.include?(rank) and FILES.include?(file)
  end

  def self.nick_name(first_name, last_name)
    first_name.slice(..1).concat(last_name.slice(-2..)).upcase
  end

  def self.move_message(first_name, last_name, square)
    self.valid_square?(square[-1].to_i, square[0]) ? 
    "#{self.nick_name(first_name, last_name)} moved to #{square}" :
    "#{self.nick_name(first_name, last_name)} attempted to move to #{square}, but that is not a valid square"
  end
end
