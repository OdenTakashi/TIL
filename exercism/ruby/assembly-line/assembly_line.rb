class AssemblyLine
  BASE_PRODUUCTION_RATE = 221.0

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    case @speed
    when 1..4
      BASE_PRODUUCTION_RATE * @speed
    when 5..8
      BASE_PRODUUCTION_RATE * @speed * 0.9
    when 9
      BASE_PRODUUCTION_RATE * @speed * 0.8
    when 10
      BASE_PRODUUCTION_RATE * @speed * 0.77
    else
      raise 'Invalid speed'
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60.0).to_i
  end
end
