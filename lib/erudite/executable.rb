# coding: utf-8

module Erudite
  # TODO
  class Executable
    def self.run(*names)
      names.each do |name|
        contents = File.open(name) do |file|
          file.read
        end
        examples = Parser.parse(contents)
        examples.each.with_index do |example, index|
          if example.pass?
            puts "#{index + 1}. PASS"
          else
            puts <<-TXT
#{index + 1}. FAIL
  Source: #{example.source}
  Expected:
    Output: #{example.expected.output}
    Result: #{example.expected.result}
  Actual:
    Output: #{example.actual.output}
    Result: #{example.actual.result}
            TXT
          end
        end
      end
    end
  end
end
