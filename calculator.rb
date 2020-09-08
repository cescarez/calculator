
#Methods
def get_input
  input = gets.chomp.strip
  if input.match(/[0-9]/)
    input = num_input_check(input)
  end
  return input = input_check(gets.chomp.strip)
end

#note: below function performs string replacements IN PLACE
def operator_str_to_sym(operator)
  if operator.match(/[a-z]/)
    if operator == "multiply"
      operator.gsub!("multiply", "*")
    elsif operator == "divide"
      operator.gsub!("divide", "/")
    elsif operator == "add"
      operator.gsub!("add", "+")
    elsif operator == "subtract"
      operator.gsub!("subtract", "-")
    elsif operator == "exponent"
      operator.gsub!("exponent", "^")
    elsif operator == "modulo"
      operator.gsub!("modulo", "%")
    end
  end
end

def num_input_check(number)
  until number.match(/[0-9]/) && !number.include?("/")
    if number.include?("/")
      puts "Please note this program does not accept rational numbers. Please re-enter your number in decimal notation."
    end
    puts "Please re-enter a valid number: "
    number = num_input_check(gets.chomp.strip)
  end
  return number
end

def operator_input_check(operator)
  until operator == "*" || operator == "/" || operator == "+" || operator == "-" || operator == "^" || operator == "%"
    puts "This program accepts the following operators:
          'multiply' OR '*'
          'divide' OR '/'
          'add' OR '+'
          'subtract' OR '-'
          'exponent' OR '^'
          'modulo' OR '%'"
    print "Please re-enter your operation: "
    operator = operator_input_check(operator_str_to_sym(gets.chomp.downcase.strip))
  end
  return operator
end

def float_or_int(num1, num2)
  if num1.include?('.') || num2.include?('.')
    return num1.to_f, num2.to_f
  else
    return num1.to_i, num2.to_i
  end
end

#operator methods
def exponent(array_of_two_nums)
  return result = array_of_two_nums[0] ** array_of_two_nums[1]
end
def modulo(array_of_two_nums)
  return result = array_of_two_nums[0] % array_of_two_nums[1]
end
def multiply(array_of_two_nums)
  return result = array_of_two_nums[0] * array_of_two_nums[1]
end
def divide(array_of_two_nums)
  if array_of_two_nums[1] == 0
    puts "ERROR: Cannot divide by zero; the expression is undefined. Program exiting."
    exit
  else
    return result = array_of_two_nums[0] / array_of_two_nums[1]
  end
end
def add(array_of_two_nums)
  return result = array_of_two_nums[0] + array_of_two_nums[1]
end
def subtract(array_of_two_nums)
  return result = array_of_two_nums[0] - array_of_two_nums[1]
end

def evaluate(equation)
  p equation
  if equation.include?(' ')
    num1, operator, num2 = equation.split
      case operator
      when '^'
        result = exponent(float_or_int(num1, num2))
      when '%'
        result = modulo(float_or_int(num1, num2))
      when '*'
        result = multiply(float_or_int(num1, num2))
      when '/'
        result = divide(float_or_int(num1, num2))
      when '+'
        result = add(float_or_int(num1, num2))
      when '-'
        result = subtract(float_or_int(num1, num2))
      end
  end
  return result
end

#MAIN PROGRAM
print "Please input your first term to be evaluated: "
num1 = num_input_check(gets.chomp.strip)
print "Please input your operation: "
operator = operator_input_check(operator_str_to_sym(gets.chomp.downcase.strip))
print "Please input your second term to be evaluated: "
num2 = num_input_check(gets.chomp.strip)
equation = num1 + " " + operator + " " + num2

result = evaluate(equation)

puts equation + " = " + result.to_s

