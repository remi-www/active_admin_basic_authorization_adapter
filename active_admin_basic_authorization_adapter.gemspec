# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name        = 'active_admin_basic_authorization_adapter'
  gem.version     = '0.0.1'
  gem.summary     = 'An unofficial and badly tested Basic active admin authorization'
  gem.description = 'Warning, this gem is just a test for now has not a good test coverage.
  Feel free to open an issue for any problem, and please wait for a stable version before any integration.
  And it is a simple gem to handle authorizations for active admin'
  gem.authors     = ['Rémi Wallaere']
  gem.email       = 'remi.wallaere02200@hotmail.fr'
  gem.files       = ['lib/active_admin_basic_authorization_adapter.rb',
                     'lib/generators/admin_authorization/basic_admin_authorization_generator.rb',
                     'lib/generators/admin_authorization/USAGE',
                     'lib/generators/default_admin_authorization/default_basic_admin_authorization_generator.rb',
                     'lib/generators/default_admin_authorization/USAGE']
  # gem.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  # gem.files       = `git ls-files -z`.split("\x0")
  gem.homepage    =
    'https://rubygems.org/gems/active_admin_basic_authorization_adapter'
  gem.license     = 'MIT'

  gem.metadata['rubygems_mfa_required'] = 'true'
  gem.required_ruby_version = '>= 2.7.5'

  gem.add_dependency 'activesupport', '>= 3.0.0'
  gem.add_dependency 'pundit', '~> 2.2'
  gem.add_development_dependency 'actionpack', '>= 3.0.0'
  gem.add_development_dependency 'activeadmin', '>=2.13.0'
  gem.add_development_dependency 'activemodel', '>= 3.0.0'
  # gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'pry', '~> 0.14.0'
  gem.add_development_dependency 'railties', '>= 3.0.0'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubocop', '1.24.0'
  gem.add_development_dependency 'rubocop-rspec', '2.0.0'
end
