require_relative 'text_evaluator'

lines = File.read("input.txt")
output = TextEvaluator.new(lines).parse_input
out_file = File.new("output.txt", "w")
out_file.print(output)
out_file.close

