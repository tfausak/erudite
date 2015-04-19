# coding: utf-8

require 'coveralls'
Coveralls.wear!

require 'erudite'

# Strip leading whitespace.
def dedent(string)
  string.gsub(/^#{string[/\A\s*/]}/, '')
end
