# coding: utf-8

require 'parser/current'

module Erudite
  # Extracts examples from comments.
  class Extractor
    def self.extract(source)
      group_comments(parse_comments(source))
        .map { |group| group.flat_map { |comment| extract_text(comment) } }
        .map { |text| find_examples(group_text(text)).join("\n") }
        .reject(&:empty?)
        .map { |example| Example::Parser.parse(example) }
    end

    def self.find_examples(groups)
      groups
        .reject(&:empty?)
        .each_with_object([]) do |lines, examples|
          lines.first.match(/^(\s*)>> /) do |match|
            if lines.all? { |line| line.start_with?(match[1]) }
              examples.push(lines.map { |line| line[match[1].size..-1] })
            end
          end
        end
    end

    def self.group_text(lines)
      lines.each_with_object([[]]) do |line, groups|
        if line[/^\s*$/]
          groups.push([])
        else
          groups.last.push(line.chomp)
        end
      end
    end

    def self.extract_text(comment)
      if comment.inline?
        [comment.text[1..-1]]
      else
        comment.text[7..-6].lines.map(&:chomp)
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
