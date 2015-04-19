# coding: utf-8

lib = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.push(lib) unless $LOAD_PATH.include?(lib)

require 'erudite/version'

Gem::Specification.new do |gem|
  gem.name = 'erudite'
  gem.version = Erudite::VERSION
  gem.summary = 'Test interactive Ruby examples.'
  gem.description = <<-'TEXT'
    Erudite helps you turn your documentation into tests. It is like a Ruby
    version of the Python doctest module.
  TEXT
  gem.homepage = 'http://taylor.fausak.me/erudite/'
  gem.author = 'Taylor Fausak'
  gem.email = 'taylor@fausak.me'
  gem.license = 'MIT'
  gem.executable = 'erudite'

  gem.files = %w(.irbrc CHANGELOG.md LICENSE.md README.md) +
    Dir.glob(File.join(gem.require_path, '**', '*.rb'))
  gem.test_files = Dir.glob(File.join('spec', '**', '*.rb'))

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'parser', '~> 2.2'

  gem.add_development_dependency 'coveralls', '~> 0.8'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rspec', '~> 3.2'
  gem.add_development_dependency 'rubocop', '~> 0.30'
end
