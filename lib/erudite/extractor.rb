# coding: utf-8

require 'parser/current'

module Erudite
  # Extracts examples from comments.
  class Extractor
    def self.parse_comments(source)
      Parser::CurrentRuby.parse_with_comments(source).last
    end
  end
end
