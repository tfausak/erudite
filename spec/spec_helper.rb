# coding: utf-8

require 'coveralls'
Coveralls.wear!

require 'erudite'

# Monkey patch String to add ability to strip leading whitespace.
class String
  def dedent
    gsub(/^#{self[/\A\s*/]}/, '')
  end
end
