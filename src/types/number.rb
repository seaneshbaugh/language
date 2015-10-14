module Language
  module Types
    class Number
      attr_accessor :value

      def initialize(value)
        @value = value.to_i
      end

      def inspect
        to_s
      end

      def to_s
        @value.to_s
      end
    end
  end
end
