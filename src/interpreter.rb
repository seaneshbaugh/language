require_relative 'builtins/comparison/equal'
require_relative 'builtins/lists/length'
require_relative 'builtins/macros/defun'
require_relative 'builtins/math/product'
require_relative 'builtins/math/sum'
require_relative 'builtins/output/print'
require_relative 'types/boolean'
require_relative 'types/function'
require_relative 'types/number'
require_relative 'types/string'

module Language
  class Interpreter
    attr_accessor :symbol_table

    def initialize
      @symbol_table = {
        '==' => [Language::Builtins::Comparison::Equal, :function],
        '*' => [Language::Builtins::Math::Product, :function],
        '+' => [Language::Builtins::Math::Sum, :function],
        'length' => [Language::Builtins::Lists::Length, :function],
        'print' => [Language::Builtins::Output::Print, :function],
        'defun' => [Language::Builtins::Macros::Defun, :macro]
      }
    end

    def eval(ast)
      ast.map do |expression|
        function, *arguments = *expression.parts

        return nil if function.nil? # empty expression?

        fail "\"#{function.value}\" is not a symbol." if function.type != :symbol

        fail "Unknown function \"#{function.value}\"." unless @symbol_table.keys.include?(function.value)

        name, type = @symbol_table[function.value]

        arguments = arguments.map do |argument|
          case type
          when :function
            case argument.type
            when :expression
              self.eval([argument]).first
            when :number
              instantiate_number(argument)
            when :string
              instantiate_string(argument)
            else
              fail "#{argument.type} not implemented yet."
            end
          when :macro
            argument
          else
            fail "Unknown type for symbol \"#{name}\"."
          end
        end

        case type
        when :function
          name.call(*arguments)
        when :macro
          name.call(self, *arguments)
        else
          fail "Unknown type for symbol \"#{name}\"."
        end
      end
    end

    private

    def instantiate_number(number)
      if number.is_a?(Language::Types::Number)
        number
      else
        Language::Types::Number.new(number.value)
      end
    end

    def instantiate_string(string)
      if string.is_a?(Language::Types::String)
        string
      else
        Language::Types::String.new(string.value)
      end
    end
  end
end
