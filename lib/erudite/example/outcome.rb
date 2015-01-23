# coding: utf-8

module Erudite
  class Example
    # Information about an expected or actual outcome.
    class Outcome
      attr_reader :result
      attr_reader :output

      def initialize(result, output)
        @result = result
        @output = output
      end

      def ==(other)
        result == other.result &&
          output == other.output
      end
    end
  end
end
