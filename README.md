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
gem 'erudite', '~> 0.3.0'
```

Or install it manually:

``` sh
$ gem install erudite --version '~> 0.3.0'
```

## Usage

``` rb
# example.rb

# >> x = 1
# => 1
# >> x + 1
# => 2

# >> x = 2
# => 2
#
# x + 1
# => 3

# >> x
# NameError: ...

# >> f(3)
# => 9
def f(x)
  x**2
end
```

``` sh
$ erudite example.rb
- PASS
- PASS
- PASS
- PASS
- PASS
- PASS
```

[1]: https://github.com/tfausak/erudite
[2]: https://img.shields.io/gem/v/erudite.svg?style=flat
[3]: http://rubygems.org/gems/erudite
[4]: https://img.shields.io/travis/tfausak/erudite/master.svg?style=flat
[5]: https://travis-ci.org/tfausak/erudite
[6]: https://img.shields.io/coveralls/tfausak/erudite/master.svg?style=flat
[7]: https://coveralls.io/r/tfausak/erudite
[8]: https://img.shields.io/codeclimate/github/tfausak/erudite.svg?style=flat
[9]: https://codeclimate.com/github/tfausak/erudite
[10]: https://img.shields.io/gemnasium/tfausak/erudite.svg?style=flat
[11]: https://gemnasium.com/tfausak/erudite
