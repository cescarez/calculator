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
    num1, operator, num2 = parse_equation(equation, ' ', ' ')
    if num1.strip.class != Integer

    end
    if operator.strip.length > 1

    end
    if num2.strip.length > 1

    end

    num1, operator, num2 = equation.split(' ')
    ##########need to write recursive function to call evaluation for longer equations
    print "num1: "
    p num1
    print "operator: "
    p operator
    print "num2: "
    p num2
    ###################################
    case operator
    when '*', 'multiply'
      result = multiply(float_or_int(num1, num2))
    when '/', 'divide'
      result = divide(float_or_int(num1, num2))
    when '+', 'add'
      result = add(float_or_int(num1, num2))
    when '-', 'subtract'
      result = subtract(float_or_int(num1, num2))
    end
    puts equation.split(' ').length > 3 ############################
    while equation.split(' ').length > 3
      evaluate(num1, num2)
    end
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
def parse_equation(equation, prepend_char_delimiter, append_char_delimiter)
  if equation.split(prepend_char_delimiter).first
    equation_prepend, equation_to_evaluate = equation.split(prepend_char_delimiter)
  end
  if equation.split(append_char_delimiter).last
    equation_to_evaluate, equation_append = equation_to_evaluate.split(append_char_delimiter)
  end
  return equation_prepend + ";" + equation_to_evaluate + ";" + equation_append
end

def concat_equation(equation_prepend, evaluated_result, equation_append)
  p equation_prepend
  p evaluated_result
  p equation_append
  if equation_prepend && equation_append
    return new_equation = equation_prepend + evaluated_result + equation_append
  elsif equation_prepend && !equation_append
    return new_equation = equation_prepend + evaluated_result
  elsif !equation_prepend && equation_append
    return new_equation = evaluated_result + equation_append
  end
end

def parens_eval(equation)
  equation_prepend, equation_to_be_evaluated, equation_append = parse_equation(equation, '(', ')').split(';')
  puts "equation to be evaluated: #{equation_to_be_evaluated}" ##############################
  evaluated_result = evaluate(equation_to_be_evaluated)
  puts "sub-equation result: #{evaluated_result}" ##############################
  new_equation = concat_equation(equation_prepend, evaluated_result, equation_append)
  puts "New equation: #{new_equation}"
  return new_equation.to_s
end
###################I don't think this is parsing correctly
def pow_eval(equation)
  ####I'm sure this could be better
  num1 = parse_equation(equation).split(';').first.strip[-1]
  num2 = parse_equation(equation).split(';').last.strip[0]
  evaluated_result = exponent(float_or_int(num1, num2)).to_s

  if equation.split('^').first.strip[0] != equation.split('^').first.strip[-1]
    ##closing range index = -3 to account for trialing space
    equation_prepend = equation.split('^').first[0..-3]
  end
  if equation.split('^').last.strip[0] != equation.split('^').last.strip[-1]
    ##starting index = 2 to account for leading space
    equation_append = equation.split('^').last[2..-1]
  end

  new_equation = concat_equation(equation_prepend, evaluated_result, equation_prepend)
  puts "New equation: #{new_equation}"
  return new_equation.to_s
end





#######################################################################
#MAIN PROGRAM
# puts "Please input your equation to be evaluated (put spaces between all numbers and all operators). For example: '10 / (8 - 6) + 3'"
# equation = gets.chomp
# equation = "10 / (8 - 6) + 3 ^ 2"
# equation = "10 / (8 - 6) + 3"
# equation = "10 / (8 - 6)"
# equation = "(10 * 2) / 4"
equation = "10 / 8 - 6 * 3 "

result = equation
# until (result.to_i.nonzero?) || (result.class == Integer || result.class == Float) || result.to_s == "0"
until !result.to_s.include?(' ')
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