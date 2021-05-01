require_relative "lib/parser"
require_relative "lib/decryptor"

options = Parser.parse ARGV
options.validate!


decryptor = Decryptor.new(options.abs_input, options.abs_output, options.password)
decryptor.run

