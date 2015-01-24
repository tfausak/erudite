# coding: utf-8

require 'parser/current'

module Erudite
  # Extracts examples from comments.
  class Extractor
    def self.extract_text(comment)
      if comment.inline?
        comment.text[1..-1]
      else
        comment.text[7..-6]
      end
    end

    def self.group_comments(comments)
      previous = comments.first

      comments.each_with_object([]) do |comment, groups|
        groups.push([]) unless groupable?(previous, comment)
        groups.last.push(comment)
        previous = comment
      end
    end

    def self.groupable?(a, b)
      a.loc.line == b.loc.line - 1 &&
        a.loc.column == b.loc.column
    end

    def self.parse_comments(source)
      Parser::CurrentRuby.parse_with_comments(source).last
    end
  end
end
