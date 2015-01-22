# coding: utf-8

require_relative 'lib/erudite/version'

Gem::Specification.new do |gem|
  gem.name = 'erudite'
  gem.version = Erudite::VERSION.to_s
  gem.summary = 'Executable documentation.'
  gem.description = gem.summary
  gem.homepage = 'https://github.com/tfausak/erudite'
  gem.author = 'Taylor Fausak'
  gem.email = 'taylor@fausak.me'
  gem.license = 'MIT'
  gem.executable = 'erudite'

  gem.files = %w(CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md) +
    Dir.glob(File.join(gem.require_path, '**', '*.rb'))
  gem.test_files = Dir.glob(File.join('spec', '**', '*.rb'))

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rubocop', '~> 0.28'
end
