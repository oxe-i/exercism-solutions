class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    if not ALLOWED_OPERATIONS.include?(operation)
      raise UnsupportedOperation
    elsif not first_operand.instance_of?(Integer) or not second_operand.instance_of?(Integer)
      raise ArgumentError
    end

    begin
      if operation == "+"
        return "#{first_operand} + #{second_operand} = #{first_operand + second_operand}"
      elsif operation == "/"
        return "#{first_operand} / #{second_operand} = #{first_operand / second_operand}"
      else 
        return "#{first_operand} * #{second_operand} = #{first_operand * second_operand}"
      end
    rescue
      return "Division by zero is not allowed."
    end
  end
end
