# frozen_string_literal: true

module SavingsAccount
  MIN_RATE = 0.5
  MIDDLE_RATE = 1.621
  MAX_RATE = 2.475
  MINUS_RATE = 3.213

  def self.interest_rate(balance)
    case balance
    when 0...1000
      MIN_RATE
    when 1000...5000
      MIDDLE_RATE
    when 5000..Float::INFINITY
      MAX_RATE
    when -Float::INFINITY...0
      MINUS_RATE
    end
  end

  def self.annual_balance_update(balance)
    balance * (1 + interest_rate(balance) / 100.0)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0

    while current_balance < desired_balance
      current_balance = annual_balance_update(current_balance)
      years += 1
    end

    years
  end
end
