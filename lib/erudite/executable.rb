# coding: utf-8

module Erudite
  # Parses, runs, and outputs examples.
  class Executable
    def self.run(io)
      source = io.read

      Extractor.extract(source).each do |group|
        binding = TOPLEVEL_BINDING.dup
        binding.eval(source)

        group.each do |example|
          example.binding = binding
          puts format_example(example)
        end
      end
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
      <<-"TEXT"
- FAIL
  Source: #{example.source}
  Expected:
    Output: #{example.expected.output.inspect}
    Result: #{example.expected.result.inspect}
  Actual:
    Output: #{example.actual.output.inspect}
    Result: #{example.actual.result.inspect}
      TEXT
    end
  end
end
