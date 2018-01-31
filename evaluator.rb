class Evaluator
  def initialize(expressions)
    @expressions = expressions
  end
  
  def evaluate
    return calculate if is_entry_valid?
    puts "Invalid entry, exiting."
    exit!
  end

  def calculate
    stack = []
    operands = []

    @expressions.each do |token|
      case token
        when /\d/
          stack.push(token.to_f)
        when "+", "-", "/", "*"
          operands = stack.pop(2)
          stack.push(operands[0].send(token, operands[1]))
        end
    end
    stack[-1].to_f
  end

  def is_entry_valid?
    @expressions -= [""]
    return false if @expressions.count <= 2
    @expressions.each do |token|
      return false unless token.match(/\d/) || token.match(/[-|+|\/|*]/)
      return false if token.match(/\d/) && token.match(/[a-z]/i)
    end    
    true
  end

end