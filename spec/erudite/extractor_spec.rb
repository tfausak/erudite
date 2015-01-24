# coding: utf-8

require 'spec_helper'

describe Erudite::Extractor do
  describe '.parse_comments' do
    subject(:result) { described_class.parse_comments(source) }
    let(:source) { '' }

    it 'returns an array' do
      expect(result).to be_an(Array)
    end

    context 'with a comment' do
      let(:source) { '# Call me Ishmael.' }

      it 'returns the comment' do
        expect(result).to_not be_empty
        result.each { |e| expect(e).to be_a(Parser::Source::Comment) }
      end
    end
  end
end
