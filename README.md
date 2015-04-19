# [Erudite][1]

[![Version][2]][3]
[![Build][4]][5]
[![Coverage][6]][7]
[![Climate][8]][9]
[![Dependencies][10]][11]

Test interactive Ruby examples.

Erudite helps you turn your documentation into tests. It is like a Ruby version
of the [Python `doctest` module][12].

- [Installation](#installation)
- [Usage](#usage)

## Installation

To add Erudite as a dependency to your project, add it to your Gemfile.

``` rb
gem 'erudite', '~> 0.3.0'
```

For other use cases, install it manually.

``` sh
$ gem install erudite --version '~> 0.3.0'
```

Erudite uses [Semantic Versioning][13]. See [the change log][14] for a detailed
list of changes.

## Usage

``` rb
# >> f(3)
# => 9
def f(x)
  x**2
end
```

``` sh
$ erudite example.rb
- PASS
```

[1]: http://taylor.fausak.me/erudite/
[2]: https://img.shields.io/gem/v/erudite.svg?label=version&style=flat-square
[3]: http://rubygems.org/gems/erudite
[4]: https://img.shields.io/travis/tfausak/erudite/master.svg?label=build&style=flat-square
[5]: https://travis-ci.org/tfausak/erudite
[6]: https://img.shields.io/coveralls/tfausak/erudite/master.svg?label=coverage&style=flat-square
[7]: https://coveralls.io/r/tfausak/erudite
[8]: https://img.shields.io/codeclimate/github/tfausak/erudite.svg?label=climate&style=flat-square
[9]: https://codeclimate.com/github/tfausak/erudite
[10]: https://img.shields.io/gemnasium/tfausak/erudite.svg?label=dependencies&style=flat-square
[11]: https://gemnasium.com/tfausak/erudite
[12]: https://docs.python.org/library/doctest.html
[13]: http://semver.org/spec/v2.0.0.html
[14]: CHANGELOG.md
