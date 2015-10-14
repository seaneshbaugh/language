require_relative 'expression'

module Language
  class Parser
    def initialize(tokens)
      @tokens = tokens

      @length = @tokens.length
    end

    def parse!
      @current_offset = 0

      @current_expression = nil

      @parent_expressions = []

      @ast = []

      loop do
        break if @current_offset >= @length

        current_token = @tokens[@current_offset]

        @current_offset += 1

        if @current_expression
          case current_token.type
          when :sexp_start
            @parent_expressions.push(@current_expression)

            new_expression = Expression.new

            @current_expression << new_expression

            @current_expression = new_expression
          when :sexp_end
            if @current_expression
              @current_expression = @parent_expressions.pop
            else
              fail "Parse error: unexpected end of expression."
            end
          else
            @current_expression <<  current_token
          end
        else
          case current_token.type
          when :sexp_start
            @current_expression = Expression.new

            @ast.push << @current_expression
          else
            fail "Not sure what this means yet!"
          end
        end
      end

      @ast
    end
  end
end
