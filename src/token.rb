module Language
  class Token
    attr_reader :type, :value

    def initialize(type, value = '')
      @type = type

      @value = value
    end

    def <<(character)
      @value << character
    end

    def inspect
      to_s
    end

    def to_s
      if @value != ''
        if @type == :string
          value = ":#{@value.inspect}"
        else
          value = ":#{@value}"
        end
      else
        value = ''
      end

      "Token<#{@type}#{value}>"
    end
  end
end
