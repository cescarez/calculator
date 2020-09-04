#Author: Christabel Escarez
#Last updated: Sept. 3, 2020
#Ada Developer's Academy C14
#Ada Assignment, "Calculator": https://github.com/Ada-C14/calculator
#sources: 



def space_parse(equation)
  equation.split(' ')

end

def add_nums(value1, value2)
  return value1 + value2
end


def int_calculate (equation)
  if equation.include?(' ')
    parsed_equation = equation.split(' ')
    operator = parsed_equation[1]
    puts "Parsed equation: #{parsed_equation}"
    case operator
    when '+', 'add'
      result = parsed_equation[0].to_i + parsed_equation[2].to_i
    when '-', 'subtract'
      result = parsed_equation[0].to_i - parsed_equation[2].to_i
    when '/', 'divide'
      result = parsed_equation[0].to_i / parsed_equation[2].to_i
    when '*', 'multiply'
      result = parsed_equation[0].to_i * parsed_equation[2].to_i
    end
  else
    result = equation
  end
  puts "Calculate Result: #{result}"
  return result
end

def float_calculate (equation)
  if equation.include?(' ')
    parsed_equation = equation.split(' ')
    operator = parsed_equation[1]
    puts "Parsed equation: #{parsed_equation}"
    case operator
    when '+' 
      result = parsed_equation[0].to_f + parsed_equation[2].to_f
    when '-'
      result = parsed_equation[0].to_f - parsed_equation[2].to_f
    when '/'
      result = parsed_equation[0].to_f / parsed_equation[2].to_f
    when '*'
      result = parsed_equation[0].to_f * parsed_equation[2].to_f
    when '**'
      result = parsed_equation[0].to_f ** parsed_equation[2].to_f
    end
  else
    result = equation
  end
  puts "Calculate Result: #{result}"
  return result
end

def float_or_int(equation)
  if equation.include?('.')
    result = float_calculate(equation).to_s
  else 
    result = int_calculate(equation).to_s
  end
  return result
end

def parens_eval(equation)
  non_parens_equation, parens_equation = equation.split('(')
  parens_equation = parens_equation.delete(')')
  parens_result = float_or_int(parens_equation)
  puts "Parens equation: #{parens_equation}"
  new_equation = non_parens_equation + parens_result
  puts "New equation: #{new_equation}"
  return result = float_or_int(new_equation)
end

# Parentheses
puts "calculation: "

puts "Please input your equation to be evaluated (put spaces between all numbers and all: "
equation = gets.chomp

if equation.include?('(')
  result = parens_eval(equation)
else
  result = float_or_int(equation)
end   
puts equation + "= "
puts "Result: #{result}"
