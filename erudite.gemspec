# coding: utf-8

Gem::Specification.new do |gem|
  gem.name = 'erudite'
  gem.version = '0.0.0'
  gem.summary = 'Executable documentation.'
  gem.description = gem.summary
  gem.homepage = 'https://github.com/tfausak/erudite'
  gem.author = 'Taylor Fausak'
  gem.email = 'taylor@fausak.me'
  gem.license = 'MIT'

  gem.require_path = 'lib'
  gem.test_files = Dir.glob(File.join('spec', '**', '*.rb'))
  gem.files = [
    Dir.glob(File.join(gem.require_path, '**', '*.rb')),
    gem.test_files,
    %w(CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md)
  ].flatten

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_development_dependency 'rake', '~> 10.3.2'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
  gem.add_development_dependency 'rubocop', '~> 0.25.0'
end
