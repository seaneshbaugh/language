require_relative 'builtins/comparison/equal'
require_relative 'builtins/lists/length'
require_relative 'builtins/math/product'
require_relative 'builtins/math/sum'
require_relative 'builtins/output/print'
require_relative 'types/boolean'
require_relative 'types/function'
require_relative 'types/number'
require_relative 'types/string'

module Language
  class Interpreter
    def initialize
      @symbol_table = {
        '==' => Language::Builtins::Comparison::Equal,
        '*' => Language::Builtins::Math::Product,
        '+' => Language::Builtins::Math::Sum,
        'length' => Language::Builtins::Lists::Length,
        'print' => Language::Builtins::Output::Print,
      }
    end

    def eval(ast)
      ast.map do |expression|
        function, *arguments = *expression.parts

        return nil if function.nil? # empty expression?

        fail "\"#{function.value}\" is not a symbol." if function.type != :symbol

        fail "Unknown function \"#{function.value}\"." unless @symbol_table.keys.include?(function.value)

        arguments = arguments.map do |argument|
          case argument.type
          when :expression
            self.eval([argument]).first
          when :number
            Language::Types::Number.new(argument.value)
          when :string
            Language::Types::String.new(argument.value)
          else
            fail "#{argument.type} not implemented yet."
          end
        end

        @symbol_table[function.value].call(*arguments)
      end
    end
  end
end
