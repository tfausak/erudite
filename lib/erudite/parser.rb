# coding: utf-8

module Erudite
  # Parses IRB output into examples.
  class Parser
    def self.parse(string)
      group(string).map { |lines| exemplify(lines) }
    end

    def self.group(string)
      buffer = []

      groups = string.each_line.each_with_object([]) do |line, array|
        if line.start_with?('>> ') && !buffer.empty?
          array.push(buffer)
          buffer = []
        end

        buffer.push(line)
      end

      buffer.empty? ? groups : groups.push(buffer)
    end

    def self.exemplify(lines)
      source = extract_source(lines)
      result = extract_result(lines)
      output = extract_output(lines)

      Example.new(source, result, output)
    end

    def self.extract_source(lines)
      lines
        .select { |line| line.start_with?('>> ', '.. ') }
        .map { |line| line[3..-1] }
        .reduce(:+)
    end

    def self.extract_result(lines)
      lines
        .select { |line| line.start_with?('=> ') }
        .map { |line| line[3..-1] }
        .reduce(:+)
    end

    def self.extract_output(lines)
      lines
        .reject { |line| line.start_with?('>> ', '.. ', '=> ') }
        .reduce(:+)
    end
  end
end
