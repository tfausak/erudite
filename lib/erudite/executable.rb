# coding: utf-8

module Erudite
  # Parses, runs, and outputs examples.
  class Executable
    def self.run(io)
      Parser.parse(io).each { |example| puts format_example(example) }
    end

    def self.format_example(example)
      if example.pass?
        format_passing_example(example)
      else
        format_failing_example(example)
      end
    end

    def self.format_passing_example(_example)
      '- PASS'
    end

    def self.format_failing_example(example)
      <<-TXT
- FAIL
  Source: #{example.source}
  Expected:
    Output: #{example.expected.output.inspect}
    Result: #{example.expected.result.inspect}
  Actual:
    Output: #{example.actual.output.inspect}
    Result: #{example.actual.result.inspect}
      TXT
    end
  end
end
