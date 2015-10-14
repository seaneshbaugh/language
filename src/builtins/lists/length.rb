module Language
  module Builtins
    module Lists
      module Length
        def self.call(*args)
          fail "Too few arguments for length, expected 1 but got 0." if args.length == 0

          fail "Too many arguments for length, expected 1 but got #{args.length}." if args.length > 1

          case args.first
          when Language::Types::String
            Language::Types::Number.new(args.first.value.length)
          else
            fail "Length not implemented for type."
          end
        end
      end
    end
  end
end
