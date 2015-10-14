module Language
  module Builtins
    module Output
      module Print
        def self.call(*args)
          args.each do |arg|
            puts arg.inspect
          end
        end
      end
    end
  end
end
