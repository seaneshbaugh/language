module Language
  class Expression
    attr_reader :parts

    def initialize
      @parts = []
    end

    def <<(part)
      @parts << part
    end

    def inspect
      to_s
    end

    def length
      @parts.length
    end

    def to_s
      "Expression<#{@parts.map(&:to_s).join(', ')}>"
    end

    def type
      :expression
    end
  end
end
