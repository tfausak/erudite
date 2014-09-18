# [Erudite][1]

[![Gem version][2]][3]
[![Build status][4]][5]
[![Code coverage][6]][7]
[![Code quality][8]][9]
[![Dependency status][10]][11]

Executable documentation.

- [Installation](#installation)
- [Usage](#usage)

## Installation

Add it to your Gemfile:

``` rb
gem 'erudite', '~> 0.2.0'
```

Or install it manually:

``` sh
$ gem install erudite --version 0.2.0
```

This project uses [Semantic Versioning][12].

## Usage

``` irb
# example.irb
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

>> fail 'catastrophe'
RuntimeError: catastrophe

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
```

``` sh
$ erudite example.irb
- PASS
- PASS
- PASS
- PASS
- PASS
- PASS
- PASS
- PASS
- PASS
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
[12]: http://semver.org/spec/v2.0.0.html
