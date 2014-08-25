# coding: utf-8

require 'spec_helper'

describe Erudite::Parser do
  describe '.parse' do
    it 'parses an example without output or a result' do
      examples = described_class.parse(<<-'RUBY')
>> :something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(":something\n")])
    end

    it 'parses an example with a result' do
      examples = described_class.parse(<<-'RUBY')
>> :something
=> :something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(":something\n", ":something\n")])
    end

    it 'parses an example with output' do
      examples = described_class.parse(<<-'RUBY')
>> puts :something
something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("puts :something\n", nil, "something\n")])
    end

    it 'handles STDIN' do
      examples = described_class.parse(<<-'RUBY')
>> gets
=> nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("gets\n", "nil\n")])
    end

    it 'handles STDOUT' do
      examples = described_class.parse(<<-'RUBY')
>> puts :something
something
=> nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("puts :something\n", "nil\n", "something\n")])
    end

    it 'handles STDERR' do
      examples = described_class.parse(<<-'RUBY')
>> warn :something
something
=> nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("warn :something\n", "nil\n", "something\n")])
    end

    it 'handles exceptions' do
      examples = described_class.parse(<<-'RUBY')
>> fail 'something'
RuntimeError: something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(
          "fail 'something'\n", nil, "RuntimeError: something\n")])
    end

    it 'handles multi-line source and output' do
      examples = described_class.parse(<<-'RUBY')
>> puts 'some
.. thing'
some
thing
=> nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("puts 'some\nthing'\n", "nil\n", "some\nthing\n")])
    end

    it 'handles multiple examples' do
      examples = described_class.parse(<<-'RUBY')
>> def some
..   :thing
.. end
>> some
=> :thing
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("def some\n  :thing\nend\n"),
        Erudite::Example.new("some\n", ":thing\n")])
    end
  end
end
