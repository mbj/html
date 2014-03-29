# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'html'
  gem.version     = '0.1.2'
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@schirp-dso.com' ]
  gem.description = 'Because HTML is not a String'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/html'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.license          = 'MIT'
  gem.extra_rdoc_files = %w[TODO]

  gem.add_runtime_dependency('adamantium',   '~> 0.2.0')
  gem.add_runtime_dependency('equalizer',    '~> 0.0.9')
end
