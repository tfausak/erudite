# coding: utf-8

require 'English'
require 'stringio'

module Erudite
  # Code to be run and compared against its expected outcome.
  class Example
    attr_reader :source
    attr_reader :expected
    attr_writer :binding

    def initialize(source, result = nil, output = nil)
      @source = source
      @expected = Outcome.new(result, output)
    end

    def binding
      @binding ||= TOPLEVEL_BINDING.dup
    end

    def run!
      binding.eval(source, __FILE__, __LINE__)
    end

    def run
      [run!, nil]
    rescue Exception => exception # rubocop:disable Lint/RescueException
      [nil, exception]
    end

    def self.without_stdio
      stdin, stdout, stderr = $stdin, $stdout, $stderr
      argv = $ARGV
      $stdin = $stdout = $stderr = io = StringIO.new
      $ARGV.clear
      [yield, io]
    ensure
      $stdin, $stdout, $stderr = stdin, stdout, stderr
      $ARGV.concat(argv)
    end

    def self.format_exception(exception)
      "#{exception.class.name}: #{exception.message}"
    end

    def actual
      return @actual if defined?(@actual)

      result, io = self.class.without_stdio do
        result, exception = run
        warn(self.class.format_exception(exception)) if exception
        result.inspect
      end

      @actual = Outcome.new(result, io.string)
    end

    def self.pattern(string)
      Regexp.new(Regexp.escape(string).gsub('\.\.\.', '.*?'))
    end

    def valid_result?
      return true unless expected.result
      self.class.pattern(expected.result).match(actual.result)
    end

    def valid_output?
      return true unless expected.output
      self.class.pattern(expected.output).match(actual.output)
    end

    def pass?
      actual
      valid_result? && valid_output?
    end

    def ==(other)
      source == other.source &&
        expected == other.expected
    end
  end
end
