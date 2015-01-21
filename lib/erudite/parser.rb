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
      source = lines
               .select { |line| line.start_with?('>> ', '.. ') }
               .map { |line| line[3..-1].chomp }
      source.join("\n") unless source.empty?
    end

    def self.extract_result(lines)
      result = lines
               .select { |line| line.start_with?('=> ') }
               .map { |line| line[3..-1].chomp }
      result.join("\n") unless result.empty?
    end

    def self.extract_output(lines)
      output = lines
               .reject { |line| line.start_with?('>> ', '.. ', '=> ') }
               .map(&:chomp)
      output.join("\n") unless output.empty?
    end
  end
end
