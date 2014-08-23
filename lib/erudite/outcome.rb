# coding: utf-8

module Erudite
  # Information about an expected or actual outcome.
  class Outcome
    attr_reader :result
    attr_reader :output

    def initialize(result, output)
      @result = result
      @output = output
    end
  end
end
