# coding: utf-8

require 'spec_helper'

describe Erudite::Extractor do
  describe '.group_text' do
    subject(:result) { described_class.group_text(text) }
    let(:text) { '' }

    context 'with two adjacent lines' do
      let(:text) { "a\nb" }

      it 'returns the lines in their own group' do
        expect(result).to eql([%w(a b)])
      end
    end

    context 'with two separate lines' do
      let(:text) { "a\n\nb" }

      it 'returns the lines in separate groups' do
        expect(result).to eql([['a'], ['b']])
      end
    end

    context 'with two lines separated by whitespace' do
      let(:text) { "a\n \nb" }

      it 'returns the lines in separate groups' do
        expect(result).to eql([['a'], ['b']])
      end
    end
  end

  describe '.extract_text' do
    subject(:result) { described_class.extract_text(comment) }
    let(:comment) { Parser::CurrentRuby.parse_with_comments(source).last.first }
    let(:source) { '' }

    context 'with an inline comment' do
      let(:source) { '# I know kung-fu.' }

      it 'extracts the text' do
        expect(result).to eql(' I know kung-fu.')
      end
    end

    context 'with a block comment' do
      let(:source) { "=begin\nSo you lie to yourself to be happy.\n=end" }

      it 'extracts the text' do
        expect(result).to eql('So you lie to yourself to be happy.')
      end
    end
  end

  describe '.group_comments' do
    subject(:result) { described_class.group_comments(comments) }
    let(:comments) { [] }

    it 'returns an array' do
      expect(result).to be_an(Array)
    end

    context 'with an inline comment' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
          # It was a pleasure to burn.
        RUBY
      end

      it 'returns the comment in its own group' do
        expect(result).to eql([comments])
      end
    end

    context 'with multiple inline comments' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
          # It was the best of times,
          #
          # it was the worst of times, ...
        RUBY
      end

      it 'returns the comments in a group' do
        expect(result).to eql([comments])
      end
    end

    context 'with two separate inline comments' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
          # I don't know half of you half as well as I should like;

          # and I like less than half of you half as well as you deserve.
        RUBY
      end

      it 'returns the comments in separate groups' do
        expect(result).to eql([[comments.first], [comments.last]])
      end
    end

    context 'with ragged inline comments' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
          # You can't win, Darth.
            # If you strike me down,
          # I shall become more powerful than you can possibly imagine.
        RUBY
      end

      it 'returns the comments in separate groups' do
        expect(result).to eql([[comments[0]], [comments[1]], [comments[2]]])
      end
    end

    context 'with a block comment' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
=begin
Remember - the enemy's gate is down.
=end
        RUBY
      end

      it 'returns the comment in its own group' do
        expect(result).to eql([comments])
      end
    end

    context 'with two block comments' do
      let(:comments) do
        Parser::CurrentRuby.parse_with_comments(<<-'RUBY').last
=begin
Time is an illusion.
=end
=begin
Lunchtime doubly so.
=end
        RUBY
      end

      it 'returns the comments in separate groups' do
        expect(result).to eql([[comments.first], [comments.last]])
      end
    end
  end

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
