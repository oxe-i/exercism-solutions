class AssemblyLine
  def initialize(speed)
    @speed = speed
  end

  BASE_PRODUCTION_PER_HOUR = 221

  def production_rate_per_hour
    base_total_production = BASE_PRODUCTION_PER_HOUR * @speed
    
    case @speed
    when 1, 2, 3, 4
      return (base_total_production).to_f
    when 5, 6, 7, 8
      return 0.9 * base_total_production
    when 9
      return 0.8 * base_total_production
    when 10
      return 0.77 * base_total_production
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
