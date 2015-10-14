module Language
  module Builtins
    module Math
      module Product
        def self.call(*args)
          Language::Types::Number.new(args.map(&:value).inject(:*))
        end
      end
    end
  end
end
