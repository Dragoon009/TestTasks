require_relative 'evaluator'

puts "Enter equation, press 'q' to exit"
expressions = []
quit_program = false
OPERATORS = ["+", "-", "/", "*"]

while !quit_program
  expression = gets.chomp
  quit_program = true if expression == "q"                 
  unless quit_program
    if expression.split(" ").count > 1
      expressions = expression.split(" ")
      puts Evaluator.new(expressions).evaluate
    else
      expressions << expression
      puts Evaluator.new(expressions).evaluate if OPERATORS.include? expression
    end
  end
end
puts "Exited!"

