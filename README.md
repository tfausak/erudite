# [Erudite][1]

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
