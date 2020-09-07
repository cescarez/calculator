#Author: Christabel Escarez
#Last updated: Sept. 3, 2020
#Ada Developer's Academy C14
#Ada Assignment, "Calculator": https://github.com/Ada-C14/calculator
#sources:
# https://ruby-doc.org/core-2.7.1/Regexp.html
# Roadmap: *integrate exponent calc into 'evaluate' method (instead of just 'pow_eval') *lots of cleaning up of code...

#Methods

# note: below function makes string replacements IN PLACE
def get_input
  return input = input_check(operator_str_to_sym(gets.chomp))
end

def operator_str_to_sym(equation)
  equation.downcase.gsub!("multiply", '*').gsub!("divide", '/').gsub!("add", '+').gsub!("subtract", '-').gsub!("mod", '%').gsub!("modulo", '%').gsub!("pow", '^').gsub!("exponent", '^').gsub!("**", '^')
end

def input_check(equation)
  until !equation.match(/d{2}/) && !equation.match(/[\*\/\+\-\^\%]+/)
    if !equation.match(/d{2}/)
      puts "Please enter at least two numbers to perform calculation(s)"
    end
    if !equation.match(/[\*\/\+\-\^\%]+/)
    puts "Equation needs to include at least one operator:
            'multiply' OR '*'
            'divide' OR '/'
            'add' OR '+'
            'subtract' OR '-'
            'modulo' OR '%'
            'exponent' OR '^'"
    end
    equation = get_input
  end
  return equation
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

def float_or_int(num1, num2)
  if num1.include?('.') || num2.include?('.')
    return num1.to_f, num2.to_f
  else
    return num1.to_i, num2.to_i
  end
end

def concat_equation(equation_prepend, evaluated_result, equation_append)
  if equation_prepend && equation_append
    return new_equation = equation_prepend.to_s + evaluated_result.to_s + equation_append.to_s
  elsif equation_prepend && !equation_append
    return new_equation = equation_prepend.to_s + evaluated_result.to_s
  elsif !equation_prepend && equation_append
    return new_equation = evaluated_result.to_s + equation_append.to_s
  end
end

#operator methods
def parens_eval(equation)
  equation_prepend, equation_to_be_evaluated, equation_append = parse_equation(equation, '(', ')').split(';')
  puts "equation to be evaluated: #{equation_to_be_evaluated}" ##############################
  evaluated_result = evaluate(equation_to_be_evaluated)
  puts "sub-equation result: #{evaluated_result}" ##############################
  new_equation = concat_equation(equation_prepend, evaluated_result, equation_append)
  puts "New equation: #{new_equation}"
  return new_equation.to_s
end

################NEED TO DRY POW_EVAL METHOD
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
  if array_of_two_nums[1] == "0"
    puts "ERROR: Cannot divide by zero. Program exiting."
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
  if equation.to_s.include?(' ')
    # parsed_equation = parse_equation(equation, ' ', ' ').split(';')
    parsed_equation = equation.split(' ')

    num1 = parsed_equation[0]
    operator = parsed_equation[1]
    num2 = parsed_equation[2]
    ###################################
    print "num1: "
    p num1
    print "operator: "
    p operator
    print "num2: "
    p num2
    ###################################
    # ##################################
    #insert some until Mult div mod are gone, do not move to add/subtract
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
  #   case operator
  #   when '*', '/', '%'
  #     if operator == '*'
  #       result = multiply(float_or_int(num1, num2))
  #     elsif operator == '/'
  #       result = divide(float_or_int(num1, num2))
  #     elsif operator == '%'
  #       result = modulo(float_or_int(num1, num2))
  #     end
  #   when '+', '-'
  #     if operator == '+'
  #       result = add(float_or_int(num1, num2))
  #     elsif operator == '-'
  #       result = subtract(float_or_int(num1, num2))
  #     end
  #   end
  #######This is where the while loop for length WAS so multiple terms would evaluted
    #################################################
    print "evaluation result: " ######################
    p result #################
 end
  return result
end








#######################################################################
#MAIN PROGRAM
# puts "Please input your equation to be evaluated (put spaces between all numbers and all operators). For example: '10 / (8 - 6) + 3'"
# until equation
  # equation = get_input
#end
# equation = "10 / (8 - 6) + 3 ^ 2"
# equation = "10 / (8 - 6) + 3"
# equation = "10 / (8 - 6)"
# equation = "(10 * 2) / 4"
equation = "10 / 8.0 - 6 * 3 "

result = equation

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
  equation_in_progress = equation.split(' ').drop(3).join(' ')
  while !equation_in_progress.empty?
    print "equation in progress: "###########################
    p equation_in_progress ######################################
    result = evaluate(concat_equation( "",result.to_s + " ", equation_in_progress))
    equation_in_progress = equation_in_progress.split(' ').drop(2).join(' ')
    print "unevaluated equation: " ###########################
    p equation_in_progress ##########################################kk
  end
end

puts equation + " = " + result.to_s