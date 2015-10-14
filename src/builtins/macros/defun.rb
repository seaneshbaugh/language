module Language
  module Builtins
    module Macros
      module Defun
        def self.call(interpreter, *args)
          name = args.first

          name, *arguments = *args

          function = Language::Types::Function.new(interpreter, arguments)

          interpreter.symbol_table[name.value] = [function, :function]
        end
      end
    end
  end
end
