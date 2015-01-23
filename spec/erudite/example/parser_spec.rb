# coding: utf-8

require 'spec_helper'

describe Erudite::Example::Parser do
  describe '.parse' do
    it 'parses an example without output or a result' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> :something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(':something')])
    end

    it 'parses an example with a result' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> :something
        => :something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(':something', ':something')])
    end

    it 'parses an example with output' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> puts :something
        something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new('puts :something', nil, 'something')])
    end

    it 'handles STDIN' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> gets
        => nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new('gets', 'nil')])
    end

    it 'handles STDOUT' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> puts :something
        something
        => nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new('puts :something', 'nil', 'something')])
    end

    it 'handles STDERR' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> warn :something
        something
        => nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new('warn :something', 'nil', 'something')])
    end

    it 'handles exceptions' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> fail 'something'
        RuntimeError: something
      RUBY
      expect(examples).to eq([
        Erudite::Example.new(
          "fail 'something'", nil, 'RuntimeError: something')])
    end

    it 'handles multi-line source and output' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> puts 'some
        .. thing'
        some
        thing
        => nil
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("puts 'some\nthing'", 'nil', "some\nthing")])
    end

    it 'handles multiple examples' do
      examples = described_class.parse(<<-'RUBY'.dedent)
        >> def some
        ..   :thing
        .. end
        >> some
        => :thing
      RUBY
      expect(examples).to eq([
        Erudite::Example.new("def some\n  :thing\nend"),
        Erudite::Example.new('some', ':thing')])
    end
  end
end
