module Language
  module Types
    class Function
      attr_accessor :value

      def initialize(interpreter, value)
        @interpreter = interpreter

        @value = value

        @arity = @value.first.length

        @argument_list = @value.shift
      end

      def call(*args)
        fail "Wrong number of arguments passed, expected #{@arity} but got #{args.length}." if args.length != @arity

        # This is almosy definitely a terrible idea since it will lead to all kinds of unintended
        # consequences when the value bound to an argument variable changes. But maybe that's for
        # the better?
        # I think I need to implement some sort of stack for scoping and then have variables put on
        # the current level of the stack and then when they're referenced the stack will be searched
        # from bottom to top for the variable and then overwritten.
        applied_value = @value.clone

        @argument_list.parts.map { |argument| argument.value }.zip(args).each do |argument_name, argument_value|
          applied_value.each do |expression|
            substitute_argument(expression, argument_name, argument_value)
          end
        end

        @interpreter.eval(applied_value).first
      end

      def type
        :function
      end

      private

      def substitute_argument(expression, argument_name, argument_value)
        expression.parts.each_with_index do |part, index|
          case part.type
          when :expression
            substitute_argument(part, argument_name, argument_value)
          when :symbol
            expression.parts[index] = argument_value if part.value == argument_name
          end
        end
      end
    end
  end
end
