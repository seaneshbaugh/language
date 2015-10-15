require 'optparse'

require_relative 'lexer'
require_relative 'parser'
require_relative 'interpreter'

module Language
  class Command
    def initialize(args)
      @options = {
        verbose: false
      }

      options = OptionParser.new do |opt|
        opt.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] inputfile"

        opt.on('-h', '--help', 'Show this message and exit.') do
          puts opt

          exit 1
        end

        opt.on('-v', '--verbose', 'Show verbose output.') do
          @options[:verbose] = true
        end
      end

      @args = options.parse!()
    end

    def run!
      file_name = @args.first

      file_contents = File.read(file_name)

      puts file_contents if @options[:verbose]

      lexer = Language::Lexer.new(file_contents)

      tokens = lexer.lex!

      puts tokens if @options[:verbose]

      parser = Language::Parser.new(tokens)

      ast = parser.parse!

      puts ast.inspect if @options[:verbose]

      interpreter = Language::Interpreter.new

      interpreter.eval(ast)
    end
  end
end
