module Language
  module Types
    class Boolean
      attr_reader :value

      def initialize(value)
        @value = !!value
      end

      def inspect
        to_s
      end

      def value=(new_value)
        @value = !!value
      end

      def to_s
        @value.to_s
      end

      def type
        :boolean
      end
    end
  end
end
