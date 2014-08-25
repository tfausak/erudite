# coding: utf-8

require 'spec_helper'

describe Erudite::Example do
  it 'requires some source' do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  it 'can be initialized' do
    expect(described_class.new(nil)).to be_a(described_class)
  end

  it 'sets the source' do
    source = double
    example = described_class.new(source)
    expect(example.source).to eql(source)
  end

  it 'uses the default expected outcome' do
    example = described_class.new(nil)
    expect(example.expected).to be_an(Erudite::Outcome)
    expect(example.expected.result).to be(nil)
    expect(example.expected.output).to be(nil)
  end

  it 'sets the expected result' do
    result = double
    example = described_class.new(nil, result)
    expect(example.expected.result).to eql(result)
  end

  it 'sets the expected output' do
    output = double
    example = described_class.new(nil, nil, output)
    expect(example.expected.output).to eql(output)
  end

  describe '#binding' do
    it 'uses the default binding' do
      example = described_class.new(nil)
      expect(example.binding).to be_a(Binding)
      expect(example.binding.eval('self')).to be(TOPLEVEL_BINDING.eval('self'))
      expect(example.binding).to_not be(TOPLEVEL_BINDING)
    end

    it 'memoizes the binding' do
      example = described_class.new(nil)
      binding = example.binding
      expect(example.binding).to be(binding)
    end

    it 'sets the binding' do
      example = described_class.new(nil)
      binding = TOPLEVEL_BINDING.dup
      example.binding = binding
      expect(example.binding).to be(binding)
    end
  end

  describe '#run!' do
    it 'evaluates the source' do
      source = ':something'
      example = described_class.new(source)
      expect(example.run!).to eql(TOPLEVEL_BINDING.eval(source))
    end

    it 'evaluates the source in the binding' do
      source = 'variable'
      example = described_class.new(source)
      example.binding.eval('variable = :something')
      expect(example.run!).to eql(example.binding.eval(source))
    end

    it 'sets the file name' do
      example = described_class.new('fail')
      begin
        example.run!
      rescue => error
        expect(error.backtrace.first).to_not start_with('<main>:')
      end
    end

    it 'sets the line number' do
      example = described_class.new('fail')
      begin
        example.run!
      rescue => error
        expect(error.backtrace.first).to_not end_with(":1:in `<main>'")
      end
    end
  end

  describe '#run' do
    it 'returns the result' do
      source = ':something'
      example = described_class.new(source)
      expect(example.run.first).to eql(TOPLEVEL_BINDING.eval(source))
      expect(example.run.last).to be(nil)
    end

    it 'returns the exception' do
      source = 'fail'
      example = described_class.new(source)
      expect(example.run.first).to be(nil)
      expect(example.run.last).to be_a(StandardError)
    end
  end

  describe '.without_stdio' do
    it 'requires a block' do
      expect { described_class.without_stdio }.to raise_error(LocalJumpError)
    end

    it 'calls the block' do
      result = double
      expect(described_class.without_stdio { result }.first).to eql(result)
    end

    it 'redirects STDIN' do
      stdin = $stdin
      expect(described_class.without_stdio { $stdin }).to_not eq(stdin)
    end

    it 'redirects STDOUT' do
      stdout = $stdout
      expect(described_class.without_stdio { $stdout }).to_not eq(stdout)
    end

    it 'redirects STDERR' do
      stderr = $stderr
      expect(described_class.without_stdio { $stderr }).to_not eq(stderr)
    end

    it 'reconnects STDIN' do
      stdin = $stdin
      begin
        described_class.without_stdio { fail }
      rescue
        nil
      end
      expect($stdin).to eq(stdin)
    end

    it 'reconnects STDOUT' do
      stdout = $stdout
      begin
        described_class.without_stdio { fail }
      rescue
        nil
      end
      expect($stdout).to eq(stdout)
    end

    it 'reconnects STDERR' do
      stderr = $stderr
      begin
        described_class.without_stdio { fail }
      rescue
        nil
      end
      expect($stderr).to eq(stderr)
    end

    it 'returns the redirected IO' do
      expect(described_class.without_stdio {}.last).to be_a(StringIO)
    end

    it 'handles STDIN' do
      result, _ = described_class.without_stdio { gets }
      expect(result).to be(nil)
    end

    it 'handles STDOUT' do
      _, io = described_class.without_stdio { puts 'something' }
      expect(io.string).to eql("something\n")
    end

    it 'handles STDERR' do
      _, io = described_class.without_stdio { warn 'something' }
      expect(io.string).to eql("something\n")
    end
  end

  describe '.format_exception' do
    it 'formats the exception' do
      exception = StandardError.new('something')
      expect(described_class.format_exception(exception))
        .to eql("#{exception.class.name}: #{exception.message}")
    end
  end

  describe '#actual' do
    it 'sets the result' do
      example = described_class.new('"something"')
      expect(example.actual.result).to eql('"something"')
      expect(example.actual.output).to eql('')
    end

    it 'handles STDIN' do
      example = described_class.new('gets')
      expect(example.actual.result).to eql('nil')
      expect(example.actual.output).to eql('')
    end

    it 'handles STDOUT' do
      example = described_class.new('puts "something"')
      expect(example.actual.result).to eql('nil')
      expect(example.actual.output).to eql("something\n")
    end

    it 'handles STDERR' do
      example = described_class.new('warn "something"')
      expect(example.actual.result).to eql('nil')
      expect(example.actual.output).to eql("something\n")
    end

    it 'handles exceptions' do
      example = described_class.new('fail StandardError, "something"')
      expect(example.actual.result).to eql('nil')
      expect(example.actual.output).to eql("StandardError: something\n")
    end

    it 'memoizes the result' do
      example = described_class.new('')
      actual = example.actual
      expect(example.actual).to be(actual)
    end
  end

  describe '.pattern' do
    it 'returns a Regexp' do
      pattern = described_class.pattern('something')
      expect(pattern).to be_a(Regexp)
    end

    it 'escapes meta characters' do
      pattern = described_class.pattern('some.thing')
      expect(pattern).to eql(/some\.thing/)
    end

    it 'replaces "..."' do
      pattern = described_class.pattern('some...thing')
      expect(pattern).to eql(/some.*?thing/)
    end
  end

  describe '#valid_result?' do
    it 'returns true without an expected result' do
      example = described_class.new(nil, nil)
      expect(example).to be_valid_result
    end

    it 'returns true when the results match' do
      example = described_class.new('"something"', '"something"')
      expect(example).to be_valid_result
    end

    it "returns false when the results don't match" do
      example = described_class.new('"something"', '"something else"')
      expect(example).to_not be_valid_result
    end

    it 'allows wildcards' do
      example = described_class.new('Object.new', '#<Object:0x...>')
      expect(example).to be_valid_result
    end
  end

  describe '#valid_output?' do
    it 'returns true without expected output' do
      example = described_class.new(nil, nil)
      expect(example).to be_valid_output
    end

    it 'returns true when the output matches' do
      example = described_class.new('puts "something"', nil, 'something')
      expect(example).to be_valid_output
    end

    it "returns false when the output doesn't match" do
      example = described_class.new('puts "something"', nil, 'something else')
      expect(example).to_not be_valid_output
    end

    it 'allows wildcards' do
      example = described_class.new('puts Object.new', nil, '#<Object:0x...>')
      expect(example).to be_valid_output
    end
  end

  describe '#pass?' do
    it 'realizes the actual outcome' do
      example = described_class.new('x = 1')
      example.pass?
      expect(example.binding.eval('x')).to eql(1)
    end

    it 'returns true if both the result and output match' do
      example = described_class
        .new('p "something"', '"something"', '"something"')
      expect(example).to be_pass
    end

    it "returns false if the result doesn't match" do
      example = described_class
        .new('p "something"', '"something else"', '"something"')
      expect(example).to_not be_pass
    end

    it "returns false if the output doesn't match" do
      example = described_class
        .new('p "something"', '"something"', '"something else"')
      expect(example).to_not be_pass
    end
  end

  describe '#==' do
    it 'returns true when they have the same source, result, and output' do
      source = 'x'
      result = 'y'
      output = 'z'
      a = described_class.new(source, result, output)
      b = described_class.new(source, result, output)
      expect(a).to eq(b)
    end

    it "returns false when they don't have the same source" do
      result = 'y'
      output = 'z'
      a = described_class.new('a', result, output)
      b = described_class.new('b', result, output)
      expect(a).to_not eq(b)
    end

    it "returns false when they don't have the same result" do
      source = 'x'
      output = 'z'
      a = described_class.new(source, 'a', output)
      b = described_class.new(source, 'b', output)
      expect(a).to_not eq(b)
    end

    it "returns false when they don't have the same output" do
      source = 'x'
      result = 'y'
      a = described_class.new(source, result, 'a')
      b = described_class.new(source, result, 'b')
      expect(a).to_not eq(b)
    end
  end
end
