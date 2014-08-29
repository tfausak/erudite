# [Erudite][1]

[![Gem version][2]][3]
[![Build status][4]][5]
[![Code coverage][6]][7]
[![Code quality][8]][9]
[![Dependency status][10]][11]

Executable documentation.

``` rb
examples = Erudite::Parser.parse(<<-'RUBY')
>> 1 + 2
=> 3

>> Object.new
=> #<Object:0x...>

>> gets
=> nil

>> puts 'hello world'
hello world
=> nil

>> warn 'oh noes'
oh noes
=> nil

>> fail 'catastrophe!'
RuntimeError: catastrophe!

>> puts 'chunky
.. bacon'
chunky
bacon
=> nil

>> def double(n)
..   2 * n
.. end
>> double(3)
=> 6
RUBY

examples.each do |example|
  if example.pass?
    puts 'PASS'
  else
    puts 'FAIL'
    puts " expected : #{example.expected.result.inspect}"
    puts "          : #{example.expected.output.inspect}"
    puts " actual   : #{example.actual.result.inspect}"
    puts "          : #{example.actual.output.inspect}"
  end
end
```

[1]: https://github.com/tfausak/erudite
[2]: https://badge.fury.io/rb/erudite.svg
[3]: http://rubygems.org/gems/erudite
[4]: https://travis-ci.org/tfausak/erudite.svg
[5]: https://travis-ci.org/tfausak/erudite
[6]: https://img.shields.io/coveralls/tfausak/erudite.svg
[7]: https://coveralls.io/r/tfausak/erudite
[8]: https://codeclimate.com/github/tfausak/erudite/badges/gpa.svg
[9]: https://codeclimate.com/github/tfausak/erudite
[10]: https://gemnasium.com/tfausak/erudite.svg
[11]: https://gemnasium.com/tfausak/erudite
