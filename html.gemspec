# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'html'
  gem.version     = '0.0.1'
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@seonic.net' ]
  gem.description = 'Because html is not a string'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/html'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]

  gem.add_runtime_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_runtime_dependency('backports',           '~> 2.6')
  gem.add_runtime_dependency('faraday',             '~> 0.8.4')
  gem.add_runtime_dependency('adamantium',          '~> 0.0.1')
  gem.add_runtime_dependency('equalizer',           '~> 0.0.1')
  gem.add_runtime_dependency('abstract_class',      '~> 0.0.1')
end
