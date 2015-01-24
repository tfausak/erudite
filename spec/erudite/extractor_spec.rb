# coding: utf-8

require 'spec_helper'

describe Erudite::Extractor do
  describe '.groupable?' do
    subject(:result) { described_class.groupable?(a, b) }
    let(:a) { comments.first }
    let(:b) { comments.last }
    let(:comments) { Parser::CurrentRuby.parse_with_comments(source).last }
    let(:source) { '' }

    context 'with two adjacent comments' do
      let(:source) { "# 1\n# 2" }

      it 'returns true' do
        expect(result).to be(true)
      end
    end

    context 'with two separate comments' do
      let(:source) { "# 1\n\n# 2" }

      it 'returns false' do
        expect(result).to be(false)
      end
    end

    context 'with two ragged comments' do
      let(:source) { "# 1\n # 2" }

      it 'returns false' do
        expect(result).to be(false)
      end
    end
  end

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