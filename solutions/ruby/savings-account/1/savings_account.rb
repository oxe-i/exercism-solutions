module SavingsAccount
  def self.interest_rate(balance)
    if balance < 0
      return 3.213
    elsif balance < 1000
      return 0.5
    elsif balance < 5000
      return 1.621
    end
    2.475
  end

  def self.annual_balance_update(balance)
    balance * (1 + (SavingsAccount.interest_rate(balance) / 100))
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    count = 0
    
    while current_balance.abs < desired_balance.abs
      current_balance = SavingsAccount.annual_balance_update(current_balance)
      count += 1
    end

    count
  end
end
