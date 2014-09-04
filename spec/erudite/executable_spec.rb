# coding: utf-8

require 'spec_helper'

describe Erudite::Executable do
  let(:example) { Erudite::Example.new(source, example_result) }
  let(:source) { '' }
  let(:example_result) { nil }

  describe '.run' do
    subject(:result) { described_class.run(io) }
    let(:io) { StringIO.new(input) }
    let(:input) { '' }

    before { @stdout, $stdout = $stdout, StringIO.new }
    after { $stdout = @stdout }

    it 'returns an array' do
      expect(result).to be_an(Array)
    end

    context 'with input' do
      let(:input) { ">> p(true)\ntrue\n=> true\n" }

      it 'returns the example' do
        expect(result).to_not be_empty
        result.each do |example|
          expect(example).to be_an(Erudite::Example)
        end
      end

      it 'prints the results' do
        result
        expect($stdout.string).to eql("- PASS\n")
      end
    end
  end

  describe '.format_example' do
    subject(:result) { described_class.format_example(example) }

    context 'passing' do
      let(:source) { 'true' }
      let(:example_result) { 'true' }

      it 'starts with "- PASS"' do
        expect(result).to start_with('- PASS')
      end
    end

    context 'failing' do
      let(:source) { 'true' }
      let(:example_result) { 'false' }

      it 'starts with "- FAIL"' do
        expect(result).to start_with('- FAIL')
      end
    end
  end

  describe '.format_passing_example' do
    subject(:result) { described_class.format_passing_example(example) }

    it 'starts with "- PASS"' do
      expect(result).to start_with('- PASS')
    end
  end

  describe '.format_failing_example' do
    subject(:result) { described_class.format_failing_example(example) }

    it 'starts with "- FAIL"' do
      expect(result).to start_with('- FAIL')
    end
  end
end
