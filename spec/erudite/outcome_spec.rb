# coding: utf-8

require 'spec_helper'

describe Erudite::Outcome do
  it 'requires a result' do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  it 'requires some output' do
    expect { described_class.new(nil) }.to raise_error(ArgumentError)
  end

  it 'can be initialized' do
    expect(described_class.new(nil, nil)).to be_a(described_class)
  end

  it 'sets the result' do
    result = double
    outcome = described_class.new(result, nil)
    expect(outcome.result).to eql(result)
  end

  it 'sets the output' do
    output = double
    outcome = described_class.new(nil, output)
    expect(outcome.output).to eql(output)
  end
end
