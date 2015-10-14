module Language
  module Builtins
    module Math
      module Sum
        def self.call(*args)
          types = args.map(&:type).uniq

          fail  "Mismatched types." if types.length > 1

          case types.first
          when :number
            Language::Types::Number.new(args.map(&:value).inject(:+))
          when :string
            Language::Types::String.new(args.map(&:value).inject(:+))
          else
            fail "Don't know how to sum #{types.first}."
          end
        end
      end
    end
  end
end
