#Author: Christabel Escarez
#Last updated: Sept. 3, 2020
#Ada Developer's Academy C14
#Ada Assignment, "Calculator": https://github.com/Ada-C14/calculator
#sources:


#Methods

#operator methods
def exponent(array_of_two_nums)
  return result = array_of_two_nums[0] ** array_of_two_nums[1]
end

def multiply(array_of_two_nums)
  return result = array_of_two_nums[0] * array_of_two_nums[1]
end

def divide(array_of_two_nums)
  return result = array_of_two_nums[0] / array_of_two_nums[1]
end

def add(array_of_two_nums)
  return result = array_of_two_nums[0] + array_of_two_nums[1]
end

def subtract(array_of_two_nums)
  return result = array_of_two_nums[0] - array_of_two_nums[1]
end

#other program methods
def float_or_int(num1, num2)
  if num1.include?('.') || num2.include?('.')
    return num1.to_f, num2.to_f
  else
    return num1.to_i, num2.to_i
  end
end

def evaluate(equation)
  if equation.to_s.include?(' ')
    num1, operator, num2 = equation.split(' ')
    case operator
    # when '^'
    #   result = exponent(float_or_int(num1, num2))
    when '*', 'multiply'
      result = multiply(float_or_int(num1, num2))
    when '/', 'divide'
      result = divide(float_or_int(num1, num2))
    when '+', 'add'
      result = add(float_or_int(num1, num2))
    when '-', 'subtract'
      result = subtract(float_or_int(num1, num2))
    end
  else
    result = equation
  end
  print "evaluation result: " ######################
  p result #################
  # p result.class
  # p result.to_i == result
  # p result.to_i == 100
  # p result.to_i.nonzero?
  # p (result == Integer || result.class == Float)
  # # puts (result.to_i == Integer || result.to_f.class == Float)
  # p result.to_s == "0"
  return result
end
################NEED TO DRY PARENS_EVAL AND POW_EVAL METHODS
def parens_eval(equation)
  if equation.split('(').first
    equation_prepend, equation_to_evaluate = equation.split('(')
  end
  if equation.split(')').last
    equation_to_evaluate, equation_append = equation_to_evaluate.split(')')
  end
  puts "equation to be evaluated: #{equation_to_evaluate}" ##############################
  equation_to_evaluate_result = evaluate(equation_to_evaluate)
  puts "sub-equation result: #{equation_to_evaluate_result}" ##############################
  if equation_prepend && equation_append
    new_equation = equation_prepend + equation_to_evaluate_result.to_s + equation_append
  elsif equation_prepend && !equation_append
    new_equation = equation_prepend + equation_to_evaluate_result.to_s
  elsif !equation_prepend && equation_append
    new_equation = equation_to_evaluate_result.to_s + equation_append
  end
  puts "New equation: #{new_equation}"
  return new_equation.to_s
end
###################I don't think this is parsing correctly
def pow_eval(equation)
  ####I'm sure this could be better
  # num1 = equation.split('^').first.last
  # num2 = equation.split('^').last.first
  # ###############fix parsing
  num1 = equation.split('^').first
  num2 = equation.split('^').last
  p num1
  p num2
  return result = exponent(float_or_int(num1, num2)).to_s
end





#######################################################################
#MAIN PROGRAM
# puts "Please input your equation to be evaluated (put spaces between all numbers and all operators). For example: '10 / (8 - 6) + 3'"
# equation = gets.chomp
equation = "10 / (8 - 6) + 3 ^ 2"
# equation = "10 / (8 - 6) + 3"
# equation = "10 / (8 - 6)"
# equation = "(10 * 2) / 4"
result = equation
# until (result.to_i.nonzero?) || (result.class == Integer || result.class == Float) || result.to_s == "0"
until !result.include?(' ')
  if result.include?('(') || result.include?('^')
    while result.include?('(')
      result = parens_eval(result)
    end
    while result.include?('^')
      result = pow_eval(result)
    end
  end
  result = evaluate(result)
end

puts equation + " = " + result.to_s