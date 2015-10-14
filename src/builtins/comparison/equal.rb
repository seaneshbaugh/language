module Language
  module Builtins
    module Comparison
      module Equal
        def self.call(*args)
          Language::Types::Boolean.new(args.map(&:value).uniq.length == 1)
        end
      end
    end
  end
end
