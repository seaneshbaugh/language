require_relative 'lexer'
require_relative 'parser'
require_relative 'interpreter'

module Language
  class Command
    def initialize(argv)
      @argv = argv
    end

    def run!
      file_name = ARGV.first

      file_contents = File.read(file_name)

      puts file_contents

      lexer = Language::Lexer.new(file_contents)

      tokens = lexer.lex!

      puts tokens

      parser = Language::Parser.new(tokens)

      ast = parser.parse!

      puts ast.inspect

      interpreter = Language::Interpreter.new

      interpreter.eval(ast)
    end
  end
end
