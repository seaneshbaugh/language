module Language
  module Types
    class String
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def type
        :string
      end
    end
  end
end
