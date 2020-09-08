
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
    end
  end
  puts "This is what is in operator_str_to_sym: #{operator}"
  p operator
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
  # until operator.match(/[[\*]?[\/]?[\+]?[\-]?]{1}/)
  until operator == "*" || operator == "/" || operator == "+" || operator == "-"
    puts "This program accepts the following operators:
          'multiply' OR '*'
          'divide' OR '/'
          'add' OR '+'
          'subtract' OR '-'"
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

def parse_equation(equation, prepend_char_delimiter, append_char_delimiter)
  if equation.split(prepend_char_delimiter).first
    equation_prepend, equation_to_evaluate = equation.split(prepend_char_delimiter)
  end
  if equation.split(append_char_delimiter).last
    equation_to_evaluate, equation_append = equation_to_evaluate.split(append_char_delimiter)
  end
  return equation_prepend.to_s + ";" + equation_to_evaluate.to_s + ";" + equation_append.to_s
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
  if equation.include?(' ')
    num1, operator, num2 = equation.split

    if equation.match(/[\*\/\%]+/)
      case operator
      when '*'
        result = multiply(float_or_int(num1, num2))
      when '/'
        result = divide(float_or_int(num1, num2))
      when '%'
        result = modulo(float_or_int(num1, num2))
      end
    else
      case operator
      when '+'
        result = add(float_or_int(num1, num2))
      when '-'
        result = subtract(float_or_int(num1, num2))
      end
    end
  end
  return result
end

#MAIN program ##################################
#MAIN PROGRAM
print "Please input your first term to be evaluated: "
num1 = num_input_check(gets.chomp.strip)
print "Please input your operation: "
operator = operator_input_check(operator_str_to_sym(gets.chomp.downcase.strip))
print "Please input your second term to be evaluated: "
num2 = num_input_check(gets.chomp.strip)
equation = num1 + " " + operator + " " + num2

# until equation
# equation = get_input
#end
# equation = "10 / (8 - 6) + 3 ^ 2"
# equation = "10 / (8 - 6) + 3"
# equation = "10 / (8 - 6)"
# equation = "(10 * 2) / 4"
# equation = "10 / 8.0 - 6 * 3 "

result = evaluate(equation)

# equation_in_progress = result.to_s + " " + equation.split(' ').drop(3).join(' ')
# while !equation_in_progress.empty?
#   operator = equation_in_progress.split(' ')[1]
#   if operator == '+' || operator == '-'
#     next_equation = (equation_in_progress.split(' ').drop(2).join(' ')).to_s
#     next_operator = next_equation[next_equation =~ /[\*\/\+\-\^\%]+/]
#     next_result = evaluate(next_equation).to_s
#     equation_in_progress = concat_equation(equation_in_progress.split.first, operator, next_result).to_s
#   end
#   result = evaluate(equation_in_progress)
#   equation_in_progress = result.to_s.split(' ').drop(2).join(' ')
# end

puts equation + " = " + result.to_s

#METHOD GRAVEYARD. ONLY TO BE ACCESSED FOR CODE NECROMANCY
#
# until !result.to_s.include?(' ')
#   if result.include?('(') || result.include?('^')
#     while result.include?('(')
#       result = parens_eval(result)
#     end
#     while result.include?('^')
#       result = pow_eval(result)
#     end
#   end
#   result = evaluate(result)
#
#   equation_in_progress = result.to_s + " " + equation.split(' ').drop(3).join(' ')
#   while !equation_in_progress.empty?
#     operator = equation_in_progress.split(' ')[1]
#     if operator == '+' || operator == '-'
#       next_equation = (equation_in_progress.split(' ').drop(2).join(' ')).to_s
#       next_operator = next_equation[next_equation =~ /[\*\/\+\-\^\%]+/]
#       next_result = evaluate(next_equation).to_s
#       equation_in_progress = concat_equation(equation_in_progress.split.first, operator, next_result).to_s
#     end
#     result = evaluate(equation_in_progress)
#     equation_in_progress = result.to_s.split(' ').drop(2).join(' ')
#   end
# end
#
#
# def concat_equation(equation_prepend, evaluated_result, equation_append)
#   if equation_prepend && equation_append
#     return new_equation = equation_prepend.to_s + " " + evaluated_result.to_s + " " + equation_append.to_s
#   elsif equation_prepend && !equation_append
#     return new_equation = equation_prepend.to_s + " " + evaluated_result.to_s
#   elsif !equation_prepend && equation_append
#     return new_equation = evaluated_result.to_s + " " + equation_append.to_s
#   end
# end

# #operator methods
# def parens_eval(equation)
#   equation_prepend, equation_to_be_evaluated, equation_append = parse_equation(equation, '(', ')').split(';')
#   evaluated_result = evaluate(equation_to_be_evaluated)
#   new_equation = concat_equation(equation_prepend, evaluated_result, equation_append)
#   return new_equation.to_s
# end
#
# ################NEED TO DRY POW_EVAL METHOD
# def pow_eval(equation)
#   ####I'm sure this could be better
#   num1 = parse_equation(equation).split(';').first.strip[-1]
#   num2 = parse_equation(equation).split(';').last.strip[0]
#   evaluated_result = exponent(float_or_int(num1, num2)).to_s
#
#   if equation.split('^').first.strip[0] != equation.split('^').first.strip[-1]
#     ##closing range index = -3 to account for trialing space
#     equation_prepend = equation.split('^').first[0..-3]
#   end
#   if equation.split('^').last.strip[0] != equation.split('^').last.strip[-1]
#     ##starting index = 2 to account for leading space
#     equation_append = equation.split('^').last[2..-1]
#   end
#
#   new_equation = concat_equation(equation_prepend, evaluated_result, equation_prepend)
#   puts "New equation: #{new_equation}"
#   return new_equation.to_s
# end
