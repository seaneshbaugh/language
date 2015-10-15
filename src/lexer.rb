require_relative 'token'

module Language
  class Lexer
    def initialize(code)
      @code = code

      @length = @code.length
    end

    def lex!
      @current_offset = 0

      @current_token = nil

      @tokens = []

      loop do
        break if @current_offset >= @length

        current_character = @code[@current_offset]

        @current_offset += 1

        if @current_token
          continue_token(current_character)
        else
          start_token(current_character)
        end
      end

      @tokens
    end

    private

    def continue_token(current_character)
      case current_character
      when/\s/
        check_for_literal_symbols

        @tokens << @current_token

        @current_token = nil
      when ')'
        check_for_literal_symbols

        @tokens << @current_token

        @current_token = nil

        @tokens << Token.new(:sexp_end)
      when '"'
        if @current_token.type == :string
          @tokens << @current_token

          @current_token = nil
        else
          fail "Unexpected end of string."
        end
      else
        if @current_token.type == :string
          if current_character == "\\"
            if @current_offset < @length
              escape = @code[@current_offset]

              @current_offset += 1

              case escape
              when 'n'
                @current_token << "\n"
              when 'r'
                @current_token << "\r"
              when 't'
                @current_token << "\t"
              # TODO: Unicode escape sequences?
              else
                fail "Unknown escape sequence \"\\#{escape}\""
              end
            else
              fail "Unexepected end of input."
            end
          else
            @current_token << current_character
          end
        else
          @current_token << current_character
        end
      end
    end

    def start_token(current_character)
      case current_character
      when '('
        @tokens << Token.new(:sexp_start)
      when ')'
        @tokens << Token.new(:sexp_end)
      when "'"
        @tokens << Token.new(:literal)
      when /\s/
        return
      when /\d/
        @current_token = Token.new(:number, current_character)
      when '"'
        @current_token = Token.new(:string)
      else
        @current_token = Token.new(:symbol, current_character)
      end
    end

    def check_for_literal_symbols
      case @current_token.value
      when 'true'
        @current_token.type = :boolean
      when 'false'
        @current_token.type = :boolean
      end
    end
  end
end
